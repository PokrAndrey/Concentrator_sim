module uart_trans (
    input clk,
    input st,
    input Pon,
    output wire TXD,
    output reg next_packet_en = 1'b1,
    input wire [`packet_value*8 - 1:0]data
    );

    wire EoBit;
    wire [7:0]CRC_L;
    wire [7:0]CRC_H;
	wire next_packet;
    reg [4:0]pause_cn = 5'b0;
    reg pause = 1'b0;
    wire pause_cancel = (pause_cn == 5'd20) & EoBit;
	reg [`log_packet_value:0]SM_Tx = 0;
    assign next_packet = pause_cancel & (SM_Tx == `packet_value + 1);   
    wire load = pause_cancel | st;
    wire [7:0]byte = (SM_Tx == `packet_value) ? CRC_L :
                     (SM_Tx == `packet_value + 1) ? CRC_H : data[SM_Tx*8 +: 8];
    wire init = next_packet | Pon;

    wire LOAD_CRC = pause_cancel & ~(SM_Tx == `packet_value + 1) & ~(SM_Tx == `packet_value) | st;

    UTx UTx (.clk(clk), .next(next), .start(load), .data_out(TXD), .data_in(byte), .EoBit(EoBit));
    CRC16_trans CRC16_trans (.clk(clk), .init(init), .LOAD(LOAD_CRC), .byte(byte), .CRC_L(CRC_L), .CRC_H(CRC_H));

    

    always @(posedge clk)
    begin
		pause <= (next | Pon) ? 1'b1 : (pause_cancel | st) ? 1'b0 : pause;
        pause_cn <= (pause_cancel | Pon) ? 5'b0 : (pause & EoBit & ~next_packet_en) ? pause_cn + 5'b1 : pause_cn;
    end 

    always @(posedge clk)
    begin
        SM_Tx <= init ? 0 : load ? SM_Tx + 1 : SM_Tx;
		next_packet_en <= init ? 1'b1 : st ? 1'b0 : next_packet_en;
    end

endmodule 
