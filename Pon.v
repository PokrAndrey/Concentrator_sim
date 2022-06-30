module Pon (
	input clk,
	output reg pon = 1'b1
	);
	
	reg rst = 0;
	
	always @(posedge clk)
	begin
		rst <= 1;
		pon <= ~rst;
	end
	
endmodule