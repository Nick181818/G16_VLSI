module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    wire [7:0]x,y,z;
    my_dff8 d1(.clk(clk), .d(d), .q(x) );
    my_dff8 d2(.clk(clk), .d(x), .q(y) );
    my_dff8 d3(.clk(clk), .d(y), .q(z) );
    always@(*)
        begin
            case(sel)
                2'b00:q=d;
                2'b01:q=x;
                2'b10:q=y;
                2'b11:q=z;
            endcase    
        end    

endmodule
