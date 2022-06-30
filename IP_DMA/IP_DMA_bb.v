
module IP_DMA (
	avalon_st_data_data,
	avalon_st_data_valid,
	avalon_st_data_ready,
	avalon_st_data_startofpacket,
	avalon_st_data_endofpacket,
	clk_clk,
	reset_reset_n);	

	input	[7:0]	avalon_st_data_data;
	input		avalon_st_data_valid;
	output		avalon_st_data_ready;
	input		avalon_st_data_startofpacket;
	input		avalon_st_data_endofpacket;
	input		clk_clk;
	input		reset_reset_n;
endmodule
