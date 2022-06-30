`define V 9600
module UART_Rx 
(
    input clk,
    input RXD,
    input next,

    output reg [7:0]PAR = 0,
    output wire unload
    );

	 
	 reg pause = 1'b1;
    reg [3:0]bit_cn = 4'b0;
    reg [3:0]Tbit_cn = 4'b0;
    reg inside_ready = 1'b0;
    
    reg [6:0]SHR = 7'b0;

    reg [13:0]T_F16x_cn = 14'b0;
    wire F16x = (T_F16x_cn == (50000000/`V >> 4));

    always @(posedge clk)
    begin
        T_F16x_cn <= (T_F16x_cn == (50000000/`V >> 4)) ? 14'b0 : T_F16x_cn + 14'b1;
    end 

    always @(posedge clk)
    begin
        Tbit_cn <= (pause & RXD) ? 4'b0 : F16x ? Tbit_cn + 4'b1 : Tbit_cn;
        bit_cn <= pause ? 4'b0 : (F16x & (Tbit_cn == 4'hF)) ? bit_cn + 4'b1 : bit_cn;
        pause <= (bit_cn == 4'd9) ? 1'b1 : ((Tbit_cn == 4'd7) & pause & ~RXD) ? 1'b0 : pause;
        SHR <= ((Tbit_cn == 4'd12) & F16x) ? {RXD, SHR[6:1]} : SHR;
        PAR <= ((bit_cn == 4'd8) & (Tbit_cn == 4'd12) & F16x) ? {RXD, SHR[6:0]} : PAR;
        inside_ready <= ((bit_cn == 4'd8) & (Tbit_cn == 4'd12) & F16x) ? 1'b1 : inside_ready & next ? 1'b0 : inside_ready; 
    end 

    assign unload = inside_ready & next;

endmodule
