module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    
    always@(*)
        begin 
            case(in)
                4'b0001:pos=2'd00;
                4'b0010:pos=2'd01;
                4'b0011:pos=2'd00;
                4'b0100:pos=2'd02;
                4'b0101:pos=2'd00;
                4'b0110:pos=2'd01;
                4'b0111:pos=2'd00;
                4'b1000:pos=2'd03;
                4'b1001:pos=2'd00;
                4'ha:pos=2'd01;
                4'hb:pos=2'd00;
                4'hc:pos=2'd02;
                4'hd:pos=2'd00;
                4'he:pos=2'd01;
                4'hf:pos=2'd00;
                default:pos=2'd00;
            endcase 
        end
                

endmodule
