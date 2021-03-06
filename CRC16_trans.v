module CRC16_trans (
    input clk,
    input LOAD,
    input [7:0]byte,
    input init,
    output wire [7:0]CRC_L,
    output wire [7:0]CRC_H 
    );

    reg [15:0]CRC = 16'hFFFF;
    reg sh_bit = 1'b0;
    reg [3:0]sh_cn = 4'b0;  
    reg go = 1'b0;
    wire [15:0]w_xor = (CRC ^ 16'ha001);
    //wire [15:0]xor_sh = w_xor >> 1;
    assign CRC_L = CRC[7:0];
    assign CRC_H = CRC[15:8];

    always @(posedge clk)
    begin
        if (LOAD)
        begin
            CRC <= {CRC[15:8], CRC[7:0] ^ byte};
            sh_bit <= 1'b0;
            go <= 1'b1;
        end

        else
        begin
            if (go)
            begin
                sh_bit <= (~sh_cn[0]) ? CRC[0] : sh_bit;
                sh_cn <= sh_cn + 1'b1;
                CRC <= (~sh_cn[0]) ? {1'b0, CRC[15:1]} : sh_bit ? CRC ^ 16'ha001 : CRC;
                go <= (&sh_cn) ? 1'b0 : go;
            end
            else
            begin
                CRC <= init ? 16'hFFFF : CRC;
            end
        end
    end

endmodule
