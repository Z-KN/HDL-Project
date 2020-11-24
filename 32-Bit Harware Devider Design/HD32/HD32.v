// HD32.v

`define InputWidth 32
`define OutputWidth 32

module HD32(
    input mode, // determine the unsigned/signed division
    input [`InputWidth-1:0] dividend,
    input [`InputWidth-1:0] divider,
    output reg [`OutputWidth-1:0] quotient,
    output reg [`OutputWidth-1:0] remainder,
    output reg zero_error // if divider==0
);

reg [`InputWidth-1:0] msb_dividend; // the first "1" in dividend
reg [`InputWidth-1:0] msb_divider;  // the first "1" in divider
reg [`InputWidth-1:0] reg_dividend,temp_dividend;  
reg [`InputWidth-1:0] reg_divider,temp_divider;  
integer i; // used for shifting bits 

// convert to positive values 
// determine the msb of 1
always @(*) begin
    if (mode==0) begin // unsigned division
        reg_dividend=dividend;
        reg_divider=divider;
    end
    else begin // signed
        // if negative
        reg_dividend=dividend[`InputWidth-1]==1?~dividend[`InputWidth-1:0]+1:dividend;
        reg_divider=divider[`InputWidth-1]==1?~divider[`InputWidth-1:0]+1:divider;
    end
    msb_dividend=msb(reg_dividend);
    msb_divider=msb(reg_divider);
end

// perform division
always @(*) begin
    zero_error=0;
    // divider==0
    if (reg_divider==0) begin
        quotient=`OutputWidth'b0;
        remainder=`OutputWidth'b0;
        zero_error=1;
    end
    // compare two operands
    // dividend<divider?
    else if (reg_dividend<reg_divider) begin
        quotient=`OutputWidth'b0;
        remainder=reg_dividend;
    end
    // dividend>=divider
    else begin 
        quotient=`OutputWidth'b0;
        remainder=reg_dividend;
        temp_divider=reg_divider<<(msb_dividend-msb_divider); // variational subtrahend
        for(i=msb_dividend-msb_divider;i>=0;i=i-1) begin
            quotient=quotient<<1;
            if (remainder>=temp_divider) begin
                remainder=remainder-temp_divider;
                quotient[0]=1;
            end
            else 
                quotient[0]=0;
            temp_divider=temp_divider>>1;
        end
    end
    // convert back to correct number
    if (mode==1 && dividend[`InputWidth-1]^divider[`InputWidth-1]) // neg
        quotient[`OutputWidth-1:0]=~quotient[`OutputWidth-1:0]+1;
    if (mode==1 && dividend[`InputWidth-1])
    remainder[`OutputWidth-1:0]=~remainder[`OutputWidth-1:0]+1;
end


// function, determine msb for 1
function [`InputWidth-1:0] msb;
input [`InputWidth-1:0] in;
integer i; // iteration variable
begin
    for(i=`InputWidth-1;i>=0;i=i-1) begin
    if (in[i]==1) begin
    msb=i;
    i=0;
    end
end
end
endfunction

endmodule
