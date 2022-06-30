module multiport_access_mem (
	input clk,
	input pon,
	input [`sensors_number - 1:0]uart_channel_data,
	input sink_ready,
	input EoT_ok_rx,
	output reg read_en_without_DMA_ready = 0,
	output wire rd_en,
	output wire EoR_from_Mem,
	output wire [7:0]data_from_mem,
	output wire SoT_to_DMA,
	output reg [`sensors_number - 1:0]ok_rx = 0
	
	);
	
	integer i;
	genvar j;
	genvar k;
	genvar n;
	genvar p;
	
	//UART-receivers
	wire [`sensors_number - 1:0]unload;
	wire [7:0]DRx[`sensors_number - 1:0];
	wire [`sensors_number - 1:0]next;
	
	generate
	for(k = 0; k < `sensors_number; k = k + 1 ) 
	begin : uart_rec_generation
		UART_Rx UART_Rx (
			.clk(clk),
			.RXD(uart_channel_data[k]),
			.unload(unload[k]),
			.PAR(DRx[k]),
			.next(next[k]));
	end
	endgenerate
	
	

	//defining number of bytes (and CRC bytes) in packets from different sensors	
	
	wire [`log_packet_value - 1:0]max_offset[`sensors_number - 1 : 0];
	wire [1:0]CRC_byte_number[`sensors_number - 1 : 0];
	generate
	for(p = 0; p < `sensors_number; p = p + 1 ) 
	begin : max_offset_generation
		assign max_offset[p] = `packet_value;
		assign CRC_byte_number[p] = 2;
	end
	endgenerate
	
	
	//realization of multiport access
	reg [`log_packet_value - 1:0]offset[`sensors_number - 1:0];
	reg [`sensors_number - 1:0]ASK = 0;
	wire [`sensors_number - 1:0]SEL;
	
	reg [7:0]data[`sensors_number - 1:0];
	wire [7:0]mask_data[`sensors_number - 1:0];
	wire [7:0]or_mask_data[`sensors_number - 1:0];
	assign or_mask_data[0] = mask_data[0];
	wire [7:0]data_to_mem;
	
	wire [`log_sensors_number + `log_packet_value - 1:0]wr_address;
	wire [`log_sensors_number - 1:0]wr_channel[`sensors_number - 1:0];
	wire [`log_sensors_number + `log_packet_value - 1:0]mask_wr_address[`sensors_number - 1:0];
	wire [`log_sensors_number + `log_packet_value - 1:0]or_mask_wr_address[`sensors_number - 1:0];
	assign or_mask_wr_address[0] = mask_wr_address[0];
	
	wire [`sensors_number - 1:0]init_request;
	wire or_ASK = |ASK;
	wire or_SEL = |SEL;
	reg t_ASK = 0;
	reg t_SEL = 0;	
	wire [`sensors_number - 1:0]PV;
	assign PV[0] = 1'b1;
	wire wr_en = or_ASK & (~t_ASK | t_SEL);//(or_ASK & ~t_ASK) | (or_ASK & t_SEL);
	
	generate
	for(j = 1; j < `sensors_number; j = j + 1 ) 
	begin : PV_generation
		assign PV[j] = PV[j-1] & ~ASK[j-1];
		assign or_mask_data[j] = or_mask_data[j-1] | mask_data[j];
		assign or_mask_wr_address[j] = or_mask_wr_address[j-1] | mask_wr_address[j];
	end
	endgenerate
	
	generate
	for(j = 0; j < `sensors_number; j = j + 1 ) 
	begin : multiport_access
		assign SEL[j] = PV[j] & ASK[j];
		assign next[j] = ~ASK[j] & ~read_en_without_DMA_ready;
		assign mask_data[j] = data[j] & {8{SEL[j]}};
		assign wr_channel[j] = j;
		assign mask_wr_address[j] = {wr_channel[j], offset[j]} & {`log_sensors_number + `log_packet_value{SEL[j]}};
	end
	endgenerate
	
	assign data_to_mem = or_mask_data[`sensors_number-1];
	assign wr_address = or_mask_wr_address[`sensors_number-1];
		
	always @(posedge clk)
	begin
		t_ASK <= or_ASK;
		t_SEL <= or_SEL;
		for (i = 0; i < `sensors_number; i = i + 1 ) 
		begin
			ASK[i] <= init_request[i] ? 1'b1 : SEL[i] ? 1'b0 : ASK[i]; 
			data[i] <= init_request[i] ? DRx[i] : data[i];
		end
	end
	
	//forming address for reading
	assign rd_en = read_en_without_DMA_ready & sink_ready;	
	wire [`sensors_number - 1:0]EoR_from_UART;
	wire [`sensors_number - 1:0]EoCh_all;
	assign SoT_to_DMA = EoCh_all & (&EoR_from_UART);
	wire [`sensors_number - 1:0]EoR_for_channel;
	reg [`log_sensors_number - 1:0]channel_cn = 0;
	assign EoR_from_Mem = rd_en & sink_ready & (channel_cn == (`sensors_number - 1)) & 
							  (offset[`sensors_number - 1] == (max_offset[`sensors_number - 1] - CRC_byte_number[`sensors_number - 1] - 1));

	wire [`log_sensors_number + `log_packet_value - 1:0]rd_addr = {channel_cn, offset[channel_cn]};
	
	
	generate
	for(j = 0; j < `sensors_number; j = j + 1 ) 
	begin : address_generation
		assign init_request[j] = unload[j] & (offset[j] < (max_offset[j] - CRC_byte_number[j]));
		assign EoR_from_UART[j] = (offset[j] == max_offset[j]);
		assign EoR_for_channel[j] = (offset[j] == (max_offset[j] - CRC_byte_number[j] - 1));
	end
	endgenerate
	
	always @(posedge clk)
	begin
		channel_cn <= EoR_from_Mem ? 0 : rd_en & (|EoR_for_channel) ? channel_cn + 1 : channel_cn;
		read_en_without_DMA_ready = EoR_from_Mem ? 1'b0 : SoT_to_DMA ? 1'b1 : read_en_without_DMA_ready;
		for (i = 0; i < `sensors_number; i = i + 1 ) 
		begin
			offset[i] <= (pon | SoT_to_DMA | EoR_from_Mem) ? 0 :
						 (((unload[i] & (offset[i] < max_offset[i]) & ~(offset[i] < (max_offset[i] - CRC_byte_number[i]))) |//this branch for incrementing offset when no write to memory and SEL is zero
						 (SEL[i] & (offset[i] < (max_offset[i] - CRC_byte_number[i])))) |  //this branch for correct defining address
						 (rd_en & (channel_cn == i))) ? offset[i] + 1 : offset[i];//this branch for reading
						  
		end
	end
	
	//check CRC
	wire init_CRC = pon | SoT_to_DMA;
	wire [`sensors_number - 1:0]EoCh_wire;
	wire [`sensors_number - 1:0]ok_rx_wire;
	reg [`sensors_number - 1:0]EoCh = 0;
	
	generate
	for(n = 0; n < `sensors_number; n = n + 1 ) 
	begin : check_CRC_gen
		check_CRC check_CRC (
			.clk(clk),
			.byte_data(DRx[n]),
			.max_offset(max_offset[n]),
			.LOAD(unload[n]),
			.init(init_CRC),
			.EoCh(EoCh_wire[n]),
			.ok_rx(ok_rx_wire[n]));
	end
	endgenerate
	
	always @(posedge clk)
	begin
		for (i = 0; i < `sensors_number; i = i + 1 ) 
		begin
			EoCh[i] <= EoCh_wire[i] ? 1'b1 : SoT_to_DMA ? 1'b0 : EoCh[i];
			ok_rx[i] <= EoCh_wire[i] ? ok_rx_wire[i] : EoT_ok_rx ? 1'b0 : ok_rx[i];
		end
	end
	
	assign EoCh_all = &EoCh;
	
	
	//Memory
	RAM RAM (
		.data(data_to_mem),
		.read_addr(rd_addr),
		.write_addr(wr_address),
		.we(wr_en), 
		.rd_en(rd_en), 
		.clk(clk),
		.q(data_from_mem));
	
endmodule 