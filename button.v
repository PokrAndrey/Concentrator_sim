module button #(parameter x=18) (
    input clk,
    input key,
    output wire moment_of_press,
    output wire moment_of_depress,
	 output reg state = 0
    );

    reg [x-1:0]counter_press = 0;
    reg [x-1:0]counter_depress = 0;
    //reg state = 0;
    reg prev_state = 0;
    reg t_key = 0;
    reg tt_key = 0;
    reg ttt_key = 0;

    always @(posedge clk)
    begin
        counter_press <= (ttt_key) ? 18'b0 : counter_press + ~state;
        counter_depress <= (~ttt_key) ? 18'b0 : counter_depress + state;
        state <= counter_press[x-1] ? 1'b1 : (~counter_press[x-1] & counter_depress[x-1]) ? 1'b0 : state;
        prev_state <= state;

        t_key <= key;
        tt_key <= t_key;
        ttt_key <= tt_key;
    end

    assign moment_of_press = state & ~prev_state;
    assign moment_of_depress = ~state & prev_state;
    
endmodule 
