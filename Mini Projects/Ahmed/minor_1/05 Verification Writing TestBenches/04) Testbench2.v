module top_module();
    reg clk;
    reg in;
    reg [2:0]s;
    wire out;
    
    q7 q7 (clk, in, s, out);
    
    initial begin 
        clk = 0;
        in = 0;
        s = 2;
    #10 in = 0;
        s = 6;
    #10 in = 1;
        s = 2;
    #10 in = 0;
        s = 7;
    #10 in = 1;
        s = 0;
    #30 in = 0;
        s = 0;
    #5;
    end
    
    always
        #5 clk = !clk;

endmodule
