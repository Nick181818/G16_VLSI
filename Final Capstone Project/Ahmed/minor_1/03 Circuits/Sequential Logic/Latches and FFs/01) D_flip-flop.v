module top_module (
    input clk,    // Clocks are used in sequential circuits
    input d,
    output reg q );//
    // Use a clocked always block
	always @(posedge clk)
    //   copy d to q at every positive edge of clk
        q<=d;
    //   Clocked always blocks should use non-blocking assignments

endmodule
