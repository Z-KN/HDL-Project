module module_adds(
    input [32-1:0] operand1,operand2,
    output reg [32-1:0] result,
    output reg exception // indicating an exception
);

reg [9-1:0] shift_time;
reg [31:0] optemp1,optemp2;
reg [8-1:0] exp1,exp2;
reg [23-1:0] frac1,frac2;
reg [24-1:0] M1,M2;

reg sign;
reg [48:0] aligned; // intermediate alignment
reg [48:0] aligned_round;
reg [47:0] align_high;
reg [47:0] align_low;
reg [7:0]  first_one;

parameter NaN=32'b0_11111111_00000000000000000000001;
parameter infinity=32'b0_11111111_00000000000000000000000;

always@(*)
begin
    result=32'b0;
    exception=1'b0;
    // exception process
    // NaN // 
    if ((&operand1[30:23])&(|operand1[22:0]) || (&operand2[30:23])&(|operand2[22:0]))
    begin  
        result=NaN;
        exception=1'b1;
    end
    else
    // ifinity
    begin
        if (operand1[30:0]==infinity[30:0] || operand2[30:0]==infinity[30:0])
        begin
        result=NaN;
        exception=1'b1;
        end
    end

    // common condition
    // swap two values to make sure operand1 is larger 
    optemp1=operand1[30:0]>=operand2[30:0]?operand1:operand2;
    optemp2=operand1[30:0]>=operand2[30:0]?operand2:operand1;
    exp1=optemp1[30:23];
    exp2=optemp2[30:23];
    frac1=optemp1[22:0];
    frac2=optemp2[22:0];
    shift_time=exp1-exp2;

    M1=|optemp1[30:23]?{1'b1,frac1}:{1'b0,frac1};
    M2=|optemp2[30:23]?{1'b1,frac2}:{1'b0,frac2};
    sign=optemp1[31]^optemp2[31];
    
    aligned=0;
    align_high=0;
    align_low=0;
    if (shift_time<=8'd24) begin
        align_low[23:0]=M2;
        align_low=align_low<<(24-shift_time);
        align_high[47:24]=M1;

        aligned=~sign?align_high+align_low:align_high-align_low; // whether add or subtract a positive number
        aligned_round=aligned;
        aligned_round[48:25]=aligned[48:25]+(aligned[24]&(|aligned[23:0]))|(aligned[25]&aligned[24]);
        if(aligned_round[48]==1) // round up
        begin
            result[30:23]=optemp1[30:23]+1'b1;
            result[22:0]=aligned[47:25];
        end
        else
        begin  // need not round
            first_one=msb(aligned);
            if ((47-first_one)>=optemp1[30:23]-8'd127)
            begin
                aligned=aligned<<(optemp1[30:23]-8'd127);
                result[30:23]=8'b0;
            end
            else
            begin
                result[30:23]=optemp1[30:23]-47+first_one;
                aligned=aligned<<(48-first_one);
            end
            aligned[48:25]=aligned[48:25]+(aligned[24]&(|aligned[23:0]))|(aligned[25]&aligned[24]);
            result[22:0]=aligned[47:25];
        end
        if (result[30:23]==8'b11111111) // infinity
        begin
            result=infinity;
            exception=1'b1;
        end
    end
    else // e>24, the first one
        result[30:0]=optemp1[30:0];
    result[31]=optemp1[31]; // sign
end

// function
function [5:0] msb;
    input [48:0] in;
    integer i;
    reg flag;
begin
    flag=0;   
    for (i=48;i>=0;i=i-1)
    begin
        if (in[i]==1'b1 && flag==0)
        begin
            msb=i;
            flag=1;
        end
    end
end
endfunction

endmodule



module module_addps(
    input [64-1:0] operand1,operand2,
    output reg [64-1:0] result,
    output reg exception // indicating an exception
);
reg exception_lower,exception_upper;
module_adds add_lower(operand1[31:0],operand2[31:0],result[31:0],exception_lower);
module_adds add_upper(operand1[63:32],operand2[63:32],result[63:32],exception_upper);
always @(*) exception=exception_lower|exception_upper;
endmodule



module module_subs(
    input [32-1:0] operand1,operand2,
    output reg [32-1:0] result,
    output reg exception // indicating an exception
);
reg [32-1:0] negate_operand2;
always @(*) negate_operand2={~(operand2[31]),operand2[30:0]};
module_adds subs(operand1,negate_operand2,result,exception);
endmodule

module module_subps(
    input [64-1:0] operand1,operand2,
    output reg [64-1:0] result,
    output reg exception // indicating an exception
);
reg exception_lower,exception_upper;
module_subs sub_lower(operand1[31:0],operand2[31:0],result[31:0],exception_lower);
module_subs sub_upper(operand1[63:32],operand2[63:32],result[63:32],exception_upper);
always @(*) exception=exception_lower|exception_upper;
endmodule


module module_muls(
    input [32-1:0] operand1,operand2,
    output reg [32-1:0] result,
    output reg exception // indicating an exception
);
// reg
reg [32-1:0] reg_mul1,reg_mul2;
reg s1,s2,s;
reg [23-1:0] frac1,frac2,frac;
reg [8-1:0] exp1,exp2;
reg [9-1:0] temp_exp,exp;
reg [24-1:0] tempM1,tempM2;
reg [48-1:0] tempM,M;
reg flag_normalize,sbOr,carry_round; // sticky bit or

parameter NaN=32'b0_11111111_00000000000000000000001;
parameter infinity=32'b0_11111111_00000000000000000000000;

always @(*)
begin
    // assignment
    reg_mul1=operand1;
    s1=reg_mul1[31];
    exp1=reg_mul1[30:23];
    frac1=reg_mul1[22:0];
    reg_mul2=operand2;
    s2=reg_mul2[31];
    exp2=reg_mul2[30:23];
    frac2=reg_mul2[22:0];
    result=32'b0;
    exception=1'b0;
    // exception process first
    // NaN condition 1, NaN
    if ((&reg_mul1[30:23])&(|reg_mul1[22:0]) || (&reg_mul2[30:23])&(|reg_mul2[22:0]))
        begin result=NaN; exception=1'b1; end
    else begin
        // NaN condition 2, 0*infinity
        if (reg_mul1[30:0]==infinity[30:0] && reg_mul2[30:0]==31'b0 || reg_mul1[30:0]==31'b0 && reg_mul2[30:0]==infinity[30:0])
        begin result=NaN; exception=1'b1; end
        // infinity
        else begin
        if (reg_mul1[30:0]==infinity[30:0] || reg_mul1[30:0]==infinity[30:0]) begin
            result=infinity;
            result[31]=s1^s2;
            exception=1'b1;
        end
        // common multiplication
        else begin
            // get the hidden leading bit of M
            tempM1=(|exp1==1)?{1'b1,frac1}:{1'b0,frac1};
            tempM2=(|exp2==1)?{1'b1,frac2}:{1'b0,frac2};
            tempM=tempM1*tempM2;
            // normalize
            flag_normalize=tempM[47]==1'b1;
            M=(flag_normalize)?tempM:tempM<<1;
            // whether round
            sbOr=|M[22:0];
            // frac
            frac=M[46:24]+(M[23]&sbOr||M[22]&M[23]); // round to nearest
            carry_round=frac==(23'b0)?(1'b1):(1'b0); // carry round
            temp_exp=exp1+exp2+flag_normalize+carry_round;
            // $display("temp_exp=%d",temp_exp);
            // overflow to infinity
            if(temp_exp-8'd127>8'b11111110) begin// overflow
                result=infinity;
                result[31]=s1^s2;
                exception=1'b1;
            end
            // underflow to zero
            else if(temp_exp<8'd127) begin
                result=32'b0;
                exception=1'b1;
            end
            // common
            else begin
                exp=temp_exp-9'd127;
                result={s1^s2,exp[7:0],frac};
            end
        end
        end
    end
end

endmodule



module module_mulps(
    input [64-1:0] operand1,operand2,
    output reg [64-1:0] result,
    output reg exception // indicating an exception
);
reg exception_lower,exception_upper;
module_muls mul_lower(operand1[31:0],operand2[31:0],result[31:0],exception_lower);
module_muls mul_upper(operand1[63:32],operand2[63:32],result[63:32],exception_upper);
always @(*) exception=exception_lower|exception_upper;
endmodule

module module_divs(
    input [32-1:0] operand1,operand2,
    output reg [32-1:0] result,
    output reg exception // indicating an exception
);

// reg
reg [32-1:0] reg_dividend,reg_divider;
reg s1,s2,s;
reg [23-1:0] frac1,frac2,frac;
reg [8-1:0] exp1,exp2;
reg [9-1:0] exp;
reg [24-1:0] tempM1,tempM2;
reg [48-1:0] tempM,M;
reg flag_normalize,sbOr,carry_round; // sticky bit or

parameter NaN=32'b0_11111111_00000000000000000000001;
parameter infinity=32'b0_11111111_00000000000000000000000;
parameter zero=32'b0;

always @(*) begin
    // assignment
    reg_dividend=operand1;
    s1=reg_dividend[31];
    exp1=reg_dividend[30:23];
    frac1=reg_dividend[22:0];
    reg_divider=operand2;
    s2=reg_divider[31];
    exp2=reg_divider[30:23];
    frac2=reg_divider[22:0];
    result=32'b0;
    exception=1'b0;
    // exception process first
    // NaN condition 1, NaN
    if ((&reg_dividend[30:23])&(|reg_dividend[22:0]) || (&reg_divider[30:23])&(|reg_divider[22:0]))
        begin result=NaN; exception=1'b1; end
    else begin
        // NaN condition 2, 0/0 and inf/inf
        if (reg_dividend[30:0]==zero[30:0] && reg_dividend[30:0]==zero[30:0] || reg_dividend[30:0]==infinity[30:0] && reg_divider[30:0]==infinity[30:0])
        begin result=NaN; exception=1'b1; end
        // infinity
        else begin
        if (reg_dividend[30:0]==infinity[30:0] || reg_divider[30:0]==zero[30:0]) begin
            result=infinity;
            result[31]=s1^s2;
            exception=1'b1;
        end
        // 0
        else if (reg_divider[30:0]==infinity[30:0]) begin
            result=zero;
            result[31]=s1^s2;
            exception=1'b1;
        end
        // common divider
        else begin
            // get the hidden leading bit of M
            tempM1=(|exp1==1)?{1'b1,frac1}:{1'b0,frac1};
            tempM2=(|exp2==1)?{1'b1,frac2}:{1'b0,frac2};
            tempM=tempM1/tempM2;
            // normalize
            flag_normalize=tempM[47]==1'b1;
            M=(flag_normalize)?tempM:tempM<<1;
            // whether round
            sbOr=|M[22:0];
            // frac
            frac=M[46:24]+(M[23]&sbOr||M[22]&M[23]); // round to nearest
            carry_round=frac==(23'b0)?(1'b1):(1'b0); // carry round
            exp=exp1-exp2+8'd127+flag_normalize+carry_round;
            // overflow to infinity
            if(exp>8'b11111110) begin// overflow
                result=infinity;
                result[31]=s1^s2;
                exception=1'b1;
            end
            // underflow to zero
            else if(exp1+8'd127+flag_normalize+carry_round<exp2) begin
                result=zero;
                result[31]=s1^s2;
                exception=1'b1;
            end
            // common
            else begin
                result={s1^s2,exp[7:0],frac};
            end
        end
        end
    end
end

endmodule

// Floating Point Convert Pair to Paired Single
module module_cvtpss(
    input [32-1:0] operand1,operand2,
    output reg [64-1:0] result,
    output reg exception // indicating an exception
);
always @(*)
begin
result={operand1,operand2};
exception=1'b0;    
end
endmodule

module module_cvtsw(
    input [32-1:0] in_int,
    output reg [32-1:0] result,
    output reg exception // indicating an exception
);
reg s;
reg [31:0] pos_int,frac_temp;
reg [4:0] msb;
reg [4:0] shift;
integer i;
reg [7:0] exp;
reg [22:0] frac;
reg flag;
always @(*)
begin
    flag=1'b0;
    s=in_int[31];
    pos_int=s==1?~in_int+1:in_int;
    for(i=31;i>=0;i=i-1) begin
    if (pos_int[i]==1 && flag==1'b0) begin
    msb=i;
    flag=1'b1;
    end
    shift=6'd32-msb;  // shift time
    exp=shift+7'd127; // msb is E
    if (msb<=23) // not sufficient
    begin
        frac_temp=pos_int<<shift;
        frac=frac_temp[31-:23]; // 0 following
    end
    else // round
    begin
        frac_temp=pos_int<<shift;
        frac=frac_temp[31-:23]+(frac_temp[9]&frac_temp[8]|frac_temp[8]&(|frac_temp[7:0]));
    end
    if (frac==23'b0&&exp!=8'b0) exp=exp+1;
    result={s,exp,frac};
    exception=1'b0;
    end
end
endmodule


module module_cvtws( // maybe overflow
    input [32-1:0] float,
    output reg [32-1:0] result,
    output reg exception // indicating an exception
);
reg s1;
reg [7:0] exp1;
reg [22:0] frac;
reg [7:0] e1;
integer i;
reg sb; //sticky bit
reg [22+31:0] shiftspace;
reg [30:0] result_temp;
always @(*)
begin
    s1=float[31];
    exp1=float[30:23];
    frac=float[22:0];
    if(exp1==8'b11111111) // infinity or NaN
    begin
        exception=1'b1;
        result=31'b0;
    end
    else if (exp1>7'd127) 
    begin
        e1=exp1-7'd127; 
        if (e1>31)
        begin
            result=31'b0;
            exception=1'b1;
            // overflow         
        end
        else if (e1>=23) // 0 following
        begin
            result_temp={1'b1,frac};
            result=result_temp<<(e1-23);
            exception=1'b0;
        end
        else
        begin // not sufficient
            shiftspace={1'b1,frac}<<e1;
            result=shiftspace[53:23]+shiftspace[23]&shiftspace[22]|shiftspace[22]&(|shiftspace[21:0]);
            exception=1'b0;
        end
    end
    else
    begin 
        result=31'b0; // underflow
        exception=1'b1;
    end
    // complementary
    result=s1==1?(~{1'b1,result})+1:{1'b0,result};
end
endmodule

////////////////////////////////////////////////////////

module fpu(
    input fpu_clock,
    input fpu_reset_b,
    input [4-1:0] fpu_instr, // 15 types of instruction
    input [5-1:0] argument[3-1:0],
    input [32-1:0] data_GPR,
    output reg [32-1:0] result, // floating point
    output reg [32-1:0] data_FPR,
    output reg exception
);

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

reg [32-1:0] FPR[32-1:0]; // FPR
reg [4-1:0] reg_fpu_instr;
reg [32-1:0] operand1, operand1_paired, operand2, operand2_paired, reg_data_GPR;
reg [64-1:0] result64; // intermediate result, 64-bit
reg [5-1:0] dest, reg_dest; // for intermediate dest
reg [1:0] flag_WB; // determine whether write back, whether write 64-bit
reg exception1;

// instance
wire [32-1:0] wire32_result [5:0];
wire [64-1:0] wire64_result [3:0];
wire wire_exception [9:0]; // 6 kinds of exception
integer i;

module_adds  x_adds   (operand1 ,operand2, wire32_result[0],wire_exception[0]);
module_addps x_addps  ({operand1,operand1_paired}, {operand2,operand2_paired}, wire64_result[0],wire_exception[1]); 
module_subs  x_subs   (operand1 ,operand2, wire32_result[1],wire_exception[2]);
module_subps x_subps  ({operand1,operand1_paired}, {operand2,operand2_paired}, wire64_result[1],wire_exception[3]); 
module_muls  x_muls   (operand1 ,operand2, wire32_result[2],wire_exception[4]);
module_mulps x_mulps  ({operand1,operand1_paired}, {operand2,operand2_paired}, wire64_result[2],wire_exception[5]); 
module_divs  x_divs   (operand1 ,operand2, wire32_result[3],wire_exception[6]);
module_cvtpss x_cvtpss(operand1 ,operand2, wire64_result[3],wire_exception[7]);  // no exception
module_cvtsw x_cvtsw  (operand1 ,wire32_result[4],wire_exception[8]); // no exception
module_cvtws x_cvtws  (operand1 ,wire32_result[5],wire_exception[9]);


// always @(posedge fpu_clock)
// begin
//     if(fpu_instr==mtc1)
//     begin
//         FPR[argument[1]] <= data_GPR; //write, fs
//     end
// end
always @(fpu_instr)
begin
    if(fpu_instr==mfc1||fpu_instr==mtc1)
    begin
        data_FPR    = FPR[argument[1]]; //read, fs
        // exception = 1'b0              ;        
    end
end

initial
begin
    result=32'b0;
    for(i=0;i<=31;i=i+1) FPR[i]=32'b0;
    data_FPR= 32'b0;
    exception = 1'b0 ;
    reg_dest  = 5'b0 ;
    result64  = 64'b0;
    flag_WB   = 1'b0 ;

end
// pipeline
// ID process
always @(posedge fpu_clock)
begin
    if(!fpu_reset_b)
    begin
        reg_fpu_instr   <= idle ;
        operand1        <= 32'b0;
        operand1_paired <= 32'b0;
        operand2        <= 32'b0;
        operand2_paired <= 32'b0;
        dest            <= 5'b0 ;
        // reg_dest        <= 5'b0 ;
        // result64        <= 64'b0;
        // flag_WB         <= 1'b0 ;
        // result          <= 32'b0;
        // exception       <= 1'b0 ;
        // data_FPR        <= 32'b0;
        // for(i=0;i<=31;i=i+1) FPR[i]<=32'b0;
    end
    else // if(fpu_instr!=mfc1 && fpu_instr!=mtc1)
    begin
        operand1        <= FPR[argument[0]]; // 32-bit
        operand1_paired <= FPR[argument[0]+5'b1]; // 32-bit
        operand2        <= FPR[argument[1]]; // 32-bit
        operand2_paired <= FPR[argument[1]+5'b1]; // 32-bit
        dest            <= argument[2]     ;
        reg_data_GPR    <= data_GPR        ;
        reg_fpu_instr   <= fpu_instr       ; 
    end
end

// execution process
always @(posedge fpu_clock)
begin
    if(fpu_reset_b)
    begin
    case (reg_fpu_instr)
        idle   :begin result64 <= 64'b0                         ; exception1<=1'b0             ; flag_WB <= 2'b0 ; end
        adds   :begin result64 <= {{32{32'b0}},wire32_result[0]}; exception1<=wire_exception[0]; flag_WB <= 2'b1 ; end
        addps  :begin result64 <= wire64_result[0]              ; exception1<=wire_exception[1]; flag_WB <= 2'b1 ; end
        subs   :begin result64 <= {{32{32'b0}},wire32_result[1]}; exception1<=wire_exception[2]; flag_WB <= 2'b1 ; end
        subps  :begin result64 <= wire64_result[1]              ; exception1<=wire_exception[3]; flag_WB <= 2'b1 ; end
        muls   :begin result64 <= {{32{32'b0}},wire32_result[2]}; exception1<=wire_exception[4]; flag_WB <= 2'b1 ; end
        mulps  :begin result64 <= wire64_result[2]              ; exception1<=wire_exception[5]; flag_WB <= 2'b1 ; end
        divs   :begin result64 <= {{32{32'b0}},wire32_result[3]}; exception1<=wire_exception[6]; flag_WB <= 2'b1 ; end
        cvtpss :begin result64 <= wire64_result[3]              ; exception1<=wire_exception[7]; flag_WB <= 2'b10; end
        cvtsw  :begin result64 <= {{32{32'b0}},wire32_result[4]}; exception1<=wire_exception[8]; flag_WB <= 2'b1 ; end
        cvtws  :begin result64 <= {{32{32'b0}},wire32_result[5]}; exception1<=wire_exception[9]; flag_WB <= 2'b1 ; end
        cvtspl :begin result64 <= {{32{32'b0}},operand1}        ; exception1<=1'b0             ; flag_WB <= 2'b1 ; end // MIPS is big end
        cvtspu :begin result64 <= {{32{32'b0}},operand1}        ; exception1<=1'b0             ; flag_WB <= 2'b1 ; end
        default:begin result64 <= 64'b0                         ; exception1<=1'b0             ; flag_WB <= 2'b0 ; end
    endcase
        reg_dest<=dest;
    end
end

//WB process
always @(posedge fpu_clock)
begin
    if (fpu_reset_b)
    begin // determine whether write back
        if(fpu_instr==mtc1)
        begin
            FPR[argument[1]] <= data_GPR; //write, fs
        end
    else if (flag_WB==2'b1) // 32-bit
            FPR[reg_dest]<=result64[31:0];
    else if (flag_WB==2'b10) // .ps
        begin
            FPR[reg_dest]   <= result64[63:32];
            FPR[reg_dest+1] <= result64[31:0];
        end
        result <= result64[31:0];
        exception<=exception1;
    end
end
endmodule
