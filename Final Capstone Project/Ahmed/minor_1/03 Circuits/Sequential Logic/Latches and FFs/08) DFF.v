module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output reg q);

	always @ (posedge clk or posedge ar)begin
        if(ar==1'b1)q=1'b0;
        else q=d;
    end
    
endmodule
