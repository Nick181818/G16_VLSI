module top_module ( input clk, input d, output q );
wire w1,w2;
    my_dff d1(.d(d),.clk(clk),.q(w1));
    my_dff d2(.d(w1),.clk(clk),.q(w2));
    my_dff d3(.d(w2),.clk(clk), .q(q));
endmodule
