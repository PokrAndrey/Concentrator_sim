`define sensors_number 4
`define log_sensors_number 3
`define packet_value 3
`define log_packet_value 2
`timescale 1 ps/ 1 ps
module top_check_Concentrator_tst();
// test vector input registers
reg clk;
reg st;
reg sink_ready;
// wires                                               
wire [7:0]avalon_st_data;
wire avalon_st_valid;
wire avalon_st_startofpacket;
wire avalon_st_endofpacket;

// assign statements (if any)                          
top_check_Concentrator top_check_Concentrator(
	.clk(clk),
    .st(st),
	.sink_ready(sink_ready),
	.avalon_st_data(avalon_st_data),
	.avalon_st_valid(avalon_st_valid),
	.avalon_st_startofpacket(avalon_st_startofpacket),
	.avalon_st_endofpacket(avalon_st_endofpacket));

initial                                                
begin                                                                          
	clk = 0;   
	st = 0;    
        sink_ready = 1;                                                                           
	$display("Running testbench");                       
end   
                                                 
always                                                             
begin        
	#1; clk = ~clk; 
end  

always                                                             
begin        
	#2083333; st = 1;
	#2; st = 0;
end 
                                                
endmodule