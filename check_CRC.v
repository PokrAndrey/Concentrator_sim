module check_CRC (
    input clk,
    input LOAD,
    input [7:0]byte_data,
    input init,
	 input [`log_packet_value - 1:0]max_offset,
    output wire EoCh,
	 output wire ok_rx
    );

    reg [15:0]CRC = 16'hFFFF;
    reg sh_bit = 1'b0;
    reg [3:0]sh_cn = 4'b0;  
    reg go = 1'b0;
	 reg t_go = 1'b0;
	 reg [`log_packet_value - 1:0]cn_byte = 0;
    wire [15:0]w_xor = (CRC ^ 16'ha001);
    //wire [15:0]xor_sh = w_xor >> 1;
    wire check_sum = (CRC == 16'h0000);
	 assign EoCh = t_go & ~go & (cn_byte == max_offset);
	 assign ok_rx = EoCh & check_sum;

    always @(posedge clk)
    begin
		  t_go <= go;
        if (LOAD)
        begin
            CRC <= {CRC[15:8], CRC[7:0] ^ byte_data};
            sh_bit <= 1'b0;
            go <= 1'b1;
			cn_byte <= cn_byte + 5'b1;
        end

        else
        begin
            if (go)
            begin
                sh_bit <= (~sh_cn[0]) ? CRC[0] : sh_bit;
                sh_cn <= sh_cn + 4'b1;
                CRC <= (~sh_cn[0]) ? {1'b0, CRC[15:1]} : sh_bit ? CRC ^ 16'ha001 : CRC;
                go <= (&sh_cn) ? 1'b0 : go;
            end
            else
            begin
                CRC <= init ? 16'hFFFF : CRC;
				cn_byte <= init ? 5'b0 : cn_byte;
            end
        end
    end

endmodule
