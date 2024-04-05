module top_module( input clk, input d, output q );

    wire p,r;

    my_dff dff1(.clk(clk),.d(d),.q(p));
    my_dff dff2(.clk(clk),.d(p),.q(r));
    my_dff dff3(.clk(clk),.d(r),.q(q));
    
endmodule

