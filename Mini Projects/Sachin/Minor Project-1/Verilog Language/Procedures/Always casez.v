// synthesis verilog_input_version verilog_2001
module top_module (
    input [7:0] in,
    output reg [2:0] pos );
    
    always @(*) begin
        casez(in)
            8'b zzzzzzz1: pos = 3'b000;
            8'b zzzzzz10: pos = 3'b001;
            8'b zzzzz100: pos = 3'b010;
            8'b zzzz1000: pos = 3'b011;
            8'b zzz10000: pos = 3'b100;
            8'b zz100000: pos = 3'b101;
            8'b z1000000: pos = 3'b110;
            8'b 10000000: pos = 3'b111;
            8'b zzzzzzzz: pos = 3'b000;
            default: pos = 3'b000;
        endcase  
    end
 endmodule
