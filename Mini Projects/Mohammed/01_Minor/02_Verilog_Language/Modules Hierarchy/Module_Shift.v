module top_module (
    input clk,
    input d,
    output reg q0,
    output reg q1,
    output reg q
);

// Instantiate three my_dff modules
my_dff dff0 (.clk(clk), .d(d), .q(q0));
my_dff dff1 (.clk(clk), .d(q0), .q(q1));
my_dff dff2 (.clk(clk), .d(q1), .q(q));

endmodule