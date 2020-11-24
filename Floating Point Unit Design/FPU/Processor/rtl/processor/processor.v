module processor(
cpu_clock,
cpu_reset_b,
ins_fetch_req,
ins_pc,
instruction,
data_access_req,
data_address,
wen,
wdata,
rdata,
fpu_instr,
argument,
result,
exception,
data_GPR,
data_FPR
);

input         cpu_clock;
input         cpu_reset_b;
input  [31:0] instruction;
input  [31:0] rdata;
input  [31:0] result; // return from coprocessor
input         exception;
input  [31:0] data_FPR;
output reg        ins_fetch_req;
output reg [31:0] ins_pc;
output reg        data_access_req;
output reg [31:0] data_address;
output reg        wen;
output reg [31:0] wdata;
output reg [3:0]  fpu_instr; // to coprocessor
output reg [5-1:0] argument[3-1:0]; // to coprocessor, array
                               // [0] and [1] for fs, ft
                               // [2] for fd
output reg [32-1:0] data_GPR; // data from GPR

// intermediate reg for wire assignment
initial
begin
        data_access_req =1'b0;
        data_address    =32'b0;
        wen             =1'b0;
        wdata           =32'b0;
        fpu_instr       =3'b0;
        argument[0]     =5'b0;
        argument[1]     =5'b0;
        argument[2]     =5'b0;
        data_GPR        =5'b0;

end
always@(posedge cpu_clock)
begin
    if(!cpu_reset_b)
    begin
        // initiate
        ins_pc         <=32'b0;
        // data_access_req<=1'b0;
        // data_address   <=32'b0;
        // wen            <=1'b0;
        // wdata          <=32'b0;
        ins_fetch_req  <=1'b0;
        // fpu_instr      <=3'b0;
        // argument[0]    <=5'b0;
        // argument[1]    <=5'b0;
        // argument[2]    <=5'b0;
        // data_GPR       <=5'b0;
    end
    else
    begin
        // fetch the instruction
        ins_fetch_req<=1'b1;
        ins_pc       <=ins_pc+32'b100; //pc+4
        // instruction is auto got
    end
end

// decode process
reg [6-1:0] opcode; // the instruction opcode
reg [5-1:0] fmt; // the instruction fmt
reg [5-1:0] ft;
reg [5-1:0] rs;
reg [5-1:0] rt;
reg [5-1:0] fs;
reg [5-1:0] fd;
reg [6-1:0] func; // the instruction func
reg [16-1:0] imm;
// decode
parameter op_lui     =6'b001111;
parameter op_ori     =6'b001101;
parameter op_cop1    =6'b010001;
parameter func_add   =6'b0;
parameter func_sub   =6'b1;
parameter func_mul   =6'b10;
parameter func_div   =6'b11;
parameter func_cvtps =6'b100110;
parameter func_cvts  =6'b100000; // cvt.s
parameter func_cvtw  =6'b100100;
parameter func_cvtspl=6'b101000;
parameter func_cvtspu=6'b100000;
parameter fmt_s      =5'h10;
parameter fmt_ps     =5'h16;
parameter fmt_w      =5'h14;

// fpu_instr
parameter idle  =4'd0;
parameter adds  =4'd1;
parameter addps =4'd2;
parameter subs  =4'd3;
parameter subps =4'd4;
parameter muls  =4'd5;
parameter mulps =4'd6;
parameter divs  =4'd7;
parameter cvtpss=4'd8;
parameter cvtsw =4'd9;
parameter cvtws =4'd10;
parameter cvtspl=4'd11;
parameter cvtspu=4'd12;
parameter mfc1  =4'd13;
parameter mtc1  =4'd14;

reg [31:0] rdata_temp;

always @(*)
begin
    opcode       = instruction[31:26]; 
    fmt          = instruction[25:21]; 
    rs           = instruction[25:21]; 
    ft           = instruction[20:16]; 
    rt           = instruction[20:16]; 
    fs           = instruction[15:11]; 
    fd           = instruction[10:6] ; 
    func         = instruction[5 :0] ; 
    imm          = instruction[15:0] ;
    argument[0] = ft                ;
    argument[1] = fs                ;
    argument[2] = fd                ;

    // lui, Load Upper Immediate
    if(opcode==op_lui && instruction[25:21]==5'b0)
    begin
        fpu_instr         = idle;
        wen               = 1'b1;
        data_access_req   = 1'b1;
        data_address[6:2] = rt;
        data_address[11:7] = rt;
        wdata             = imm << 16; //GPR
        data_GPR          = 32'b0;
    end
    // ori, Or Immediate
    else if(opcode==op_ori)
    begin
        fpu_instr         = idle;
        wen               = 1'b1;
        data_access_req   = 1'b1;
        data_address[6:2] = rs; // read
        rdata_temp        = rdata;
        data_address[6:2] = rt; // write
        data_address[11:7] = rt; // write
        wdata             = rdata_temp|{16'b0,imm};
        data_GPR          = 32'b0;
    end
    // mfc1, Move Word From Floating Point
    else if(opcode==op_cop1 && instruction[25:21]==5'b00000 && instruction[10:0]==11'b0)
    begin
        fpu_instr         = mfc1    ;
        wen               = 1'b1    ;
        data_access_req   = 1'b1    ;
        data_address[6:2] = rt;
        data_address[11:7] = rt;
        wdata             = data_FPR; // wait
        data_GPR          = 32'b0   ;
    end 
    // mtc1, Move Word to Floating Point
    else if(opcode==op_cop1 && instruction[25:21]==5'b00100 && instruction[10:0]==11'b0)
    begin
        // $display("At time = %d", $time);
        // $display("instruction = %x", instruction);
        fpu_instr         = mtc1 ; 
        wen               = 1'b0 ;
        data_access_req   = 1'b0 ;
        data_address[6:2] = rt   ; 
        // $display("rt = %d", rt);
        // $display("rt = %d", rt);
        wdata             = 32'b0; 
        data_GPR          = rdata; // the data
        // $display("data_GPR = %x", data_GPR);        
    end
    // add.s
    else if(opcode==op_cop1 && fmt==fmt_s && func==func_add)
    begin
        fpu_instr         = adds;
        wen               = 1'b0 ;
        data_access_req   = 1'b0 ;
        data_address[6:2] = 5'b0 ; 
        wdata             = 32'b0;
        data_GPR          = 32'b0;
    end
    // add.ps
    else if(opcode==op_cop1 && fmt==fmt_ps && func==func_add)
    begin
        fpu_instr         = addps;
        wen               = 1'b0 ;
        data_access_req   = 1'b0 ;
        data_address[6:2] = 5'b0 ; 
        wdata             = 32'b0; 
        data_GPR          = 32'b0;
    end
    // sub.s
    else if(opcode==op_cop1 && fmt==fmt_s && func==func_sub)
    begin
        fpu_instr         = subs;
        wen               = 1'b0 ;
        data_access_req   = 1'b0 ;
        data_address[6:2] = 5'b0 ; 
        wdata             = 32'b0; 
        data_GPR          = 32'b0;
    end
    // sub.ps
    else if(opcode==op_cop1 && fmt==fmt_ps && func==func_sub)
    begin
        fpu_instr         = subps;
        wen               = 1'b0 ;
        data_access_req   = 1'b0 ;
        data_address[6:2] = 5'b0 ; 
        wdata             = 32'b0; 
        data_GPR          = 32'b0;
    end
    // mul.s
    else if(opcode==op_cop1 && fmt==fmt_s && func==func_mul)
    begin
        fpu_instr         = muls;
        wen               = 1'b0 ;
        data_access_req   = 1'b0 ;
        data_address[6:2] = 5'b0 ; 
        wdata             = 32'b0; 
        data_GPR          = 32'b0;
    end
    // mul.ps
    else if(opcode==op_cop1 && fmt==fmt_ps && func==func_mul)
    begin
        fpu_instr         = mulps;
        wen               = 1'b0 ;
        data_access_req   = 1'b0 ;
        data_address[6:2] = 5'b0 ; 
        wdata             = 32'b0; 
        data_GPR          = 32'b0;
    end
    // div.s
    else if(opcode==op_cop1 && fmt==fmt_s && func==func_div)
    begin
        fpu_instr         = divs;
        wen               = 1'b0 ;
        data_access_req   = 1'b0 ;
        data_address[6:2] = 5'b0 ; 
        wdata             = 32'b0; 
        data_GPR          = 32'b0;
    end
    // cvt.ps.s
    else if(opcode==op_cop1 && fmt==5'b10000 && func==func_cvtps)
    begin
        fpu_instr         = cvtpss;
        wen               = 1'b0 ;
        data_access_req   = 1'b0 ;
        data_address[6:2] = 5'b0 ; 
        wdata             = 32'b0; 
        data_GPR          = 32'b0;
    end
    // cvt.s.w
    else if(opcode==op_cop1 && fmt==fmt_w && instruction[20:16]==5'b00000 && func==func_cvts)
    begin
        fpu_instr         = cvtsw;
        wen               = 1'b0 ;
        data_access_req   = 1'b0 ;
        data_address[6:2] = 5'b0 ; 
        wdata             = 32'b0; 
        data_GPR          = 32'b0;
    end
    // cvt.w.s
    else if(opcode==op_cop1 && fmt==fmt_s && instruction[20:16]==5'b00000 && func==func_cvtw)
    begin
        fpu_instr         = cvtws;
        wen               = 1'b0 ;
        data_access_req   = 1'b0 ;
        data_address[6:2] = 5'b0 ; 
        wdata             = 32'b0; 
        data_GPR          = 32'b0;
    end
    // cvt.s.pl
    else if(opcode==op_cop1 && fmt==5'b10110 && instruction[20:16]==5'b00000 && func==func_cvtspl)
    begin
        fpu_instr         = cvtspl;
        wen               = 1'b0 ;
        data_access_req   = 1'b0 ;
        data_address[6:2] = 5'b0 ; 
        wdata             = 32'b0; 
        data_GPR          = 32'b0;
    end
    // cvt.s.pu
    else if(opcode==op_cop1 && fmt==5'b10110 && instruction[20:16]==5'b00000 && func==func_cvtspu)
    begin
        fpu_instr         = cvtspu;
        wen               = 1'b0 ;
        data_access_req   = 1'b0 ;
        data_address[6:2] = 5'b0 ; 
        wdata             = 32'b0; 
        data_GPR          = 32'b0;
    end
    // idle
    else
    begin
        fpu_instr         = idle;
        wen               = 1'b0 ;
        data_access_req   = 1'b0 ;
        data_address[6:2] = 5'b0 ; 
        wdata             = 32'b0; 
        data_GPR          = 32'b0;       
    end
end
endmodule

module top(
    input clk,
    input rst_b
);

wire        ins_fetch_req;
wire [31:0] ins_pc;
wire [31:0] instruction;
wire        data_access_req;
wire [31:0] data_address;
wire        wen;
wire [31:0] wdata;
wire [31:0] rdata;
wire [3:0]  instr; 
wire [4:0]  argument[2:0]; 
wire [31:0] result;
wire        exception;
wire [31:0] data_GPR;
wire [31:0] data_FPR;


processor x_processor(
  .cpu_clock        (clk                  ),
  .cpu_reset_b      (rst_b                ),
  .ins_fetch_req    (ins_fetch_req        ),
  .ins_pc           (ins_pc               ),
  .instruction      (instruction          ),  
  .data_access_req  (data_access_req      ),
  .data_address     (data_address         ),
  .wen              (wen                  ),
  .wdata            (wdata                ),
  .rdata            (rdata                ),
  .fpu_instr        (instr                ),
  .argument         (argument             ),
  .result           (result               ),
  .exception        (exception            ),
  .data_GPR         (data_GPR             ),
  .data_FPR         (data_FPR             )
);

memory x_ins_memory(
  .clock            (clk                  ), 
  .sel              (ins_fetch_req        ),
  .addr             (ins_pc               ),
  .wen              (1'b0                 ),
  .wdata            (32'b0                ),
  .rdata            (instruction          )
);

memory x_data_memory(
  .clock            (clk                  ),
  .sel              (data_access_req      ),
  .addr             (data_address         ),
  .wen              (wen                  ),
  .wdata            (wdata                ),
  .rdata            (rdata                )
);

fpu x_fpu(
  .fpu_clock        (clk                  ),
  .fpu_reset_b      (rst_b                ),
  .fpu_instr        (instr                ),
  .argument         (argument             ),
  .result           (result               ),
  .exception        (exception            ),
  .data_GPR         (data_GPR             ),
  .data_FPR         (data_FPR             )
);



endmodule