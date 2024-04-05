module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
    always @(posedge KEY[0])
    LEDR <= KEY[1] ? SW : {LEDR[2] ^ LEDR[1], LEDR[0], LEDR[2]};
endmodule
