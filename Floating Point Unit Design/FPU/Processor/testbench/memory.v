// 32*32 Memory model: Depth is 32, width is 32-bit
module memory(
clock,
sel,
addr,
wen,
wdata,
rdata
);

input           clock;
input           sel;
input  [31:0]   addr;
input           wen;
input  [31:0]   wdata;
output [31:0]   rdata;

reg    [31:0]   data_cell[31:0];
reg    [31:0]   rdata;

//write operation
always@(posedge clock)
begin
  if(sel && wen)
    // data_cell[addr[6:2]] <= wdata;
    data_cell[addr[11:7]] <= wdata;
end

always@(*)
begin
  rdata = data_cell[addr[6:2]];
end
endmodule
