module top_uart_trans (
    input clk,
    input st,
    input Pon,
    output wire [`sensors_number - 1:0]TXD,
	 output wire [7:0]ver_data
    );

    reg [(`packet_value-2)*8-1:0]data[`sensors_number - 1:0];
	wire [`sensors_number - 1:0]next_packet_en;
    wire next_packet = st & &next_packet_en;

	genvar k;
	integer i;
	
	generate
	for(k = 0; k < `sensors_number; k = k + 1 ) 
	begin : uart_trans_generation
		uart_trans uart_trans (
			.clk(clk),
			.st(next_packet),
			.TXD(TXD[k]),
			.data(data[k]),
			.Pon(Pon),
			.next_packet_en(next_packet_en[k]));
	end
	endgenerate

    always @(posedge clk)
    begin
	for (i = 0; i < `sensors_number; i = i + 1 ) 
		begin
			//data[i][(`number_of_bytes - 1)*8 +: 8] <= Pon ? 0 : next_packet ? i : data[i][(`number_of_bytes - 1)*8 +: 8];	
			data[i] <= Pon ? 8'b0 : next_packet ? data[i] + 8'b1 : data[i];
		end
    end     
	 
	 assign ver_data = data[0];

endmodule

