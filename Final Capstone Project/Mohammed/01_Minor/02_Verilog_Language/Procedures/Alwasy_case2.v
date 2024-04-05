// synthesis verilog_input_version verilog_2001
module top_module (
    input [3:0] in,
    output reg [1:0] pos  
    );
    always@(in)
        begin
            casex(in)
                4'bxxx1:pos=2'b00;
                4'bxx10:pos=2'b01;
                4'bx100:pos=2'b10;
                4'b1000:pos=2'b11;
                default:pos=2'b00;
            endcase
        end

endmodule