module RAM 
#(parameter DATA_WIDTH=8, parameter ADDR_WIDTH = `log_sensors_number + `log_packet_value)
	(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] read_addr, write_addr,
	input we, rd_en, clk,
	output wire [(DATA_WIDTH-1):0] q
	);

(*ramstyle = "M9K"*)reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
assign q = rd_en ? ram[read_addr] : 8'b01110110;
always @ (posedge clk)
begin
	if (we)
		ram[write_addr] <= data;
end

endmodule