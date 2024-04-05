module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    reg [3:1] q;
always @(posedge clk)
    if (~resetn) {q, out} <= 0;
    else {q, out} <= {in, q};
endmodule
