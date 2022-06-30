module top_check_Concentrator(
	input clk,
   input st,
	input sink_ready,
	output wire [7:0]avalon_st_data,
	output wire avalon_st_valid,
	output wire avalon_st_startofpacket,
	output wire avalon_st_endofpacket,
	output wire rd_en_without_DMA_ready,
	output wire trans_en_ok_rx,
	output wire trans_en_CRC,
	output wire [7:0]ver_data,
	output wire [1:0]ver_ok_rx
);

    wire pon;
    wire [`sensors_number - 1:0]TXD;
    wire [`sensors_number - 1:0]uart_channel_data = TXD;

    top_uart_trans top_uart_trans(
    	.clk(clk),
    	.st(st),
    	.Pon(pon),
    	.TXD(TXD),
		.ver_data(ver_data));

    DE2_115_Concentrator DE2_115_Concentrator(
		.CLOCK_50(clk),
		.Pon(pon),
		.uart_channel_data(uart_channel_data),
		.sink_ready(sink_ready),
		.avalon_st_data(avalon_st_data),
		.avalon_st_valid(avalon_st_valid),
		.avalon_st_startofpacket(avalon_st_startofpacket),
		.avalon_st_endofpacket(avalon_st_endofpacket),
		.rd_en_without_DMA_ready(rd_en_without_DMA_ready),
		.trans_en_ok_rx(trans_en_ok_rx),
		.trans_en_CRC(trans_en_CRC),
		.ver_ok_rx(ver_ok_rx));

    Pon Pon(
		.clk(clk),
		.pon(pon));

endmodule