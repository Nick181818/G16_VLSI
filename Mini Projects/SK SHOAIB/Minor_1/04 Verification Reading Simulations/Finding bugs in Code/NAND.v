module top_module (input a, input b, input c, output out);//

    wire p;

    andgate a1(p, a, b, c,1,1);
    assign out =~p;
    
endmodule
