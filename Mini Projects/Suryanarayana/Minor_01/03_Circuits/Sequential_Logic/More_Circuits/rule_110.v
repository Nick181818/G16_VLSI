module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    wire [511:0] q_left,q_right; 	
    assign q_left=q>>1; 			
    assign q_right=q<<1; 			
    always@(posedge clk)
        begin
            if(load)
                q<=data;
            else
                q <= (~q & q_right) | (q & ~q_right) | (~q_left & q_right); //Functional Equation of Rule-110
        end
endmodule
