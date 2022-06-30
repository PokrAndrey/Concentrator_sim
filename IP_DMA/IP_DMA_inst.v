	IP_DMA u0 (
		.avalon_st_data_data          (<connected-to-avalon_st_data_data>),          // avalon_st_data.data
		.avalon_st_data_valid         (<connected-to-avalon_st_data_valid>),         //               .valid
		.avalon_st_data_ready         (<connected-to-avalon_st_data_ready>),         //               .ready
		.avalon_st_data_startofpacket (<connected-to-avalon_st_data_startofpacket>), //               .startofpacket
		.avalon_st_data_endofpacket   (<connected-to-avalon_st_data_endofpacket>),   //               .endofpacket
		.clk_clk                      (<connected-to-clk_clk>),                      //            clk.clk
		.reset_reset_n                (<connected-to-reset_reset_n>)                 //          reset.reset_n
	);

