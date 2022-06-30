`define ok_rx_bytes_number (`sensors_number == 0) ? 0 : (`sensors_number - 1)/8 + 1
`define CRC_bytes_number 2
module transmit_unified_SP_to_DMA (
	input clk,
	input rd_en,
	input rd_en_without_DMA_ready,
	input EoR_from_Mem,
	input [7:0]data_from_mem,
	input sink_ready,
	input SoT_to_DMA,
	input [`sensors_number - 1:0]ok_rx,
	output reg trans_en_ok_rx = 0,
	output reg trans_en_CRC = 0,
	output wire EoT_ok_rx,
	output wire [7:0]avalon_st_data, 
	output wire avalon_st_valid, 
	output wire avalon_st_startofpacket,
	output wire avalon_st_endofpacket,
	output wire [1:0]ver_ok_rx
	);
	
	
	//transmit_ok_rx
	wire [8*`ok_rx_bytes_number - 1:0]ok_rx_full = {{(8*`ok_rx_bytes_number - `sensors_number){1'b0}}, ok_rx};
	//reg trans_en_ok_rx = 0;
	reg [`ok_rx_bytes_number-1:0]ok_rx_cn = 0;
	wire trans_en_ok_rx_with_sink_ready = sink_ready & trans_en_ok_rx;
	assign EoT_ok_rx = sink_ready & trans_en_ok_rx & (ok_rx_cn == (`ok_rx_bytes_number - 1));
	
	always @(posedge clk)
	begin 
		trans_en_ok_rx <= EoR_from_Mem ? 1'b1 : EoT_ok_rx ? 1'b0 : trans_en_ok_rx;
		ok_rx_cn <= EoT_ok_rx ? 0 : trans_en_ok_rx_with_sink_ready ? ok_rx_cn + 1 : ok_rx_cn;
	end
	
	//transmit_CRC
	//reg trans_en_CRC = 0;
	reg [`CRC_bytes_number-1:0]CRC_bytes_cn = 0;
	wire trans_en_CRC_with_sink_ready = sink_ready & trans_en_CRC;
	wire EoT_CRC = sink_ready & trans_en_CRC & (CRC_bytes_cn == (`CRC_bytes_number - 1));
	
	always @(posedge clk)
	begin
		trans_en_CRC <= EoT_ok_rx ? 1'b1 : EoT_CRC ? 1'b0 : trans_en_CRC;
		CRC_bytes_cn <= EoT_CRC ? 0 : trans_en_CRC_with_sink_ready ? CRC_bytes_cn + 1 : EoT_CRC ? 0 : CRC_bytes_cn;
	end
	
	//generate_CRC
	wire load = rd_en & trans_en_ok_rx_with_sink_ready;
	wire [7:0]data_to_CRC = rd_en ? data_from_mem : ok_rx_full[ok_rx_cn*8 +: 8];
	wire [7:0]CRC = 8'hab;
	
	/*Gen_CRC Gen_CRC (
	.data(data_to_CRC),
	.load(load),
	.CRC_byte_number(CRC_bytes_cn),
	.init(SoT_to_DMA),
	.CRC(CRC));*/
	
	//transmit all
	assign avalon_st_data = rd_en_without_DMA_ready ? data_from_mem : trans_en_ok_rx ? ok_rx_full[ok_rx_cn*8 +: 8] : CRC;
	assign avalon_st_valid = (rd_en_without_DMA_ready | trans_en_ok_rx | trans_en_CRC) & sink_ready;
	reg SoP = 0;
	assign avalon_st_startofpacket = SoP;
	assign avalon_st_endofpacket = EoT_CRC;
	
	always @(posedge clk)
	begin
		SoP <= SoT_to_DMA ? 1'b1 : sink_ready ? 1'b0 : SoP;
	end
	
	assign ver_ok_rx = {ok_rx_full[0], ok_rx[0]};
	
endmodule