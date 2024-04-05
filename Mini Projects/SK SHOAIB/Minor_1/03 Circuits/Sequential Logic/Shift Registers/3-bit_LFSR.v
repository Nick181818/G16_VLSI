module top_module (
	input [2:0] SW,      // R
    input [1:0] KEY,// L and clk
	output reg [2:0] LEDR); // Q
  
    always@(posedge KEY[0]) 
        begin 
            if(~KEY[1])
                begin 
                    LEDR[0]<=LEDR[2];
                    LEDR[1]<=LEDR[0];
                    LEDR[2]<=LEDR[1]^LEDR[2];
                end 
            else 
                begin
                    LEDR[0]<=SW[0];
                    LEDR[1]<=SW[1];
                    LEDR[2]<=SW[2];
                end 
        end
                    
endmodule
