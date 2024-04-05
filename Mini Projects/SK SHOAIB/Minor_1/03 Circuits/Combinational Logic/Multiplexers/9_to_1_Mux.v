module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );
    
    always@(*)
        begin 
            case(sel)
                4'b0000:begin out=a; end 
                4'b0001:begin out=b; end 
                4'b0010:begin out=c; end 
                4'b0011:begin out=d; end 
                4'b0100:begin out=e; end 
                4'b0101:begin out=f; end 
                4'b0110:begin out=g; end 
                4'b0111:begin out=h; end 
                4'b1000:begin out=i; end 
                default:begin out=16'b1111111111111111; end
            endcase 
        end

endmodule
