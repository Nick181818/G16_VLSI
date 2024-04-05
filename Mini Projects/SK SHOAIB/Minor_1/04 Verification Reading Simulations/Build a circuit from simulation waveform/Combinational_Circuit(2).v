module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );

    wire p,s;
    assign p=a^b;
    assign s=c^d;
    assign q = ~(p^s); 

endmodule
