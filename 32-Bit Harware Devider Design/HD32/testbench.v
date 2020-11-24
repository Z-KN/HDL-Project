// testbench.v

`define InputWidth 32
`define OutputWidth 32
`include "HD32.v"

module testbench;
// input
reg i_mode;
reg[`InputWidth-1:0] i_dividend;
reg[`InputWidth-1:0] i_divider;
// output
wire[`OutputWidth-1:0] o_quotient;
wire[`OutputWidth-1:0] o_remainder;
wire o_zero_error;

reg [7:0] delay=10; // for test

// DUT
HD32 HD32(i_mode,i_dividend,i_divider,o_quotient,o_remainder,o_zero_error);

//
initial begin
    $dumpfile("HD32.vcd");
    $dumpvars;
    $dumpon;
    #1000 $dumpoff;
    $dumpall;
end

// monitor
initial
begin
    $monitor("At time=%d\nmode=%b\ndividend=%b\ndivider=%b\nquotient=%b\nremainder=%b\no_zero_error=%b\n",
    $time,i_mode,i_dividend,i_divider,o_quotient,o_remainder,o_zero_error);
end

// test
initial
begin
    // unsigned
    #delay;
    i_mode=0;
    i_dividend=`InputWidth'b01100000; // 96
    i_divider=`InputWidth'b1100; // 12
    #delay;
    i_divider=`InputWidth'b1101; // 13
    #delay;
    i_divider=`InputWidth'b01100000; // 0
    #delay;
    i_divider=`InputWidth'b01100010; // 98
    #delay;
    i_dividend=`InputWidth'b0; // 0
    #delay;
    i_dividend=`InputWidth'b11111111_11111111_11111111_11111111; // the largest positive number
    #delay;
    i_divider=`InputWidth'b0; // 0
    // signed
    #delay;
    i_mode=1;
    i_dividend=`InputWidth'b01100000; // 96
    i_divider=`InputWidth'b1100; // 12
    #delay;
    i_divider=`InputWidth'b1101; // 13
    #delay;
    i_divider=`InputWidth'b01100000; // 0
    #delay;
    i_divider=`InputWidth'b01100010; // 98
    #delay;
    i_dividend=`InputWidth'b0; // 0
    #delay;
    i_dividend=`InputWidth'b11111111_11111111_11111111_10100000; // -96
    i_divider=`InputWidth'b1100; // 12
    #delay;
    i_divider=`InputWidth'b1101; // 13
    #delay;
    i_divider=`InputWidth'b01100010; // 98
    #delay;
    i_dividend=`InputWidth'b01100000; // 96
    i_divider=`InputWidth'b11111111111111111111111111110100; // -12
    #delay;
    i_divider=`InputWidth'b11111111111111111111111111110011; // -13
    #delay;
    i_divider=`InputWidth'b11111111_11111111_11111111_10100000; // -96
    #delay;
    i_divider=`InputWidth'b11111111111111111111111110011110; // -98
    #delay;
    i_divider=`InputWidth'b11111111_11111111_11111111_11111111; // -1
    #delay;
    i_dividend=`InputWidth'b11111111_11111111_11111111_10100000; // -96
    i_divider=`InputWidth'b11111111111111111111111111110100; // -12
    #delay;
    i_divider=`InputWidth'b11111111111111111111111111110011; // -13
    #delay;
    i_divider=`InputWidth'b11111111_11111111_11111111_10100000; // -96
    #delay;
    i_divider=`InputWidth'b11111111111111111111111110011110; // -98
    #delay;
    i_dividend=`InputWidth'b01111111_11111111_11111111_11111111; // the smallest negative number
    #delay;
    i_dividend=`InputWidth'b11111111_11111111_11111111_11111111; // -1
    #delay;
    i_dividend=`InputWidth'b0; // 0
    #delay;
    i_divider=`InputWidth'b0; // 0
end

endmodule
