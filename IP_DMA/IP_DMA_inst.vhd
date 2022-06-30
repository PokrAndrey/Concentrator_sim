	component IP_DMA is
		port (
			avalon_st_data_data          : in  std_logic_vector(7 downto 0) := (others => 'X'); -- data
			avalon_st_data_valid         : in  std_logic                    := 'X';             -- valid
			avalon_st_data_ready         : out std_logic;                                       -- ready
			avalon_st_data_startofpacket : in  std_logic                    := 'X';             -- startofpacket
			avalon_st_data_endofpacket   : in  std_logic                    := 'X';             -- endofpacket
			clk_clk                      : in  std_logic                    := 'X';             -- clk
			reset_reset_n                : in  std_logic                    := 'X'              -- reset_n
		);
	end component IP_DMA;

	u0 : component IP_DMA
		port map (
			avalon_st_data_data          => CONNECTED_TO_avalon_st_data_data,          -- avalon_st_data.data
			avalon_st_data_valid         => CONNECTED_TO_avalon_st_data_valid,         --               .valid
			avalon_st_data_ready         => CONNECTED_TO_avalon_st_data_ready,         --               .ready
			avalon_st_data_startofpacket => CONNECTED_TO_avalon_st_data_startofpacket, --               .startofpacket
			avalon_st_data_endofpacket   => CONNECTED_TO_avalon_st_data_endofpacket,   --               .endofpacket
			clk_clk                      => CONNECTED_TO_clk_clk,                      --            clk.clk
			reset_reset_n                => CONNECTED_TO_reset_reset_n                 --          reset.reset_n
		);

