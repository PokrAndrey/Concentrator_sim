`define V 9600
module UTx (
    input clk,
    input [7:0]data_in,
    input start,
    output wire data_out,
    output wire EoBit,
    output wire next
    );

    reg [3:0]T_bit = 4'b0;
    reg [3:0]Bit_cn = 4'b0;
    reg [8:0]SHR = 9'h1FF;
    reg GO = 1'b0;
    wire load = (start & ~GO);
    reg [13:0]T_F16x_cn = 14'b0;
    wire F16x = (T_F16x_cn == (50000000/`V >> 4));
    assign EoBit = (&T_bit & F16x);
    assign next = (Bit_cn == 4'd9) & EoBit;
    assign data_out = SHR[0];

    always @(posedge clk)
    begin
        T_F16x_cn <= F16x ? 14'b0 : T_F16x_cn + 14'b1;
    end 

    always @(posedge clk)
    begin
        T_bit <= load ? 4'b0 : F16x ? T_bit + 4'b1 : T_bit;
        Bit_cn <= load ? 4'b0 : (EoBit & GO) ? Bit_cn + 4'b1 : Bit_cn;
        SHR <= load ? {data_in, 1'b0} : EoBit ? {1'b1, SHR[8:1]} : SHR;
        GO <= load ? 1'b1 : ((Bit_cn == 4'd9) & EoBit) ? 1'b0 : GO;
    end

endmodule
