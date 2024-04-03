module top_module ( );
    reg clk;
    initial 
        clk = 1'b0;
    dut u1 (clk);
    always
        #5 clk = !clk;

endmodule
