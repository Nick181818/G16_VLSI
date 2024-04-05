module top_module ( input clk, input d, output q );
wire x,y;
     my_dff d1(.clk(clk), .d(d), .q(x));
     my_dff d2(.clk(clk), .d(x), .q(y));
     my_dff d3(.clk(clk), .d(y), .q(q));
endmodule