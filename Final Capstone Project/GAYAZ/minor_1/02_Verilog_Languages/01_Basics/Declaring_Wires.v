module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n  );
    wire r1,r2;
    assign r1=a&b;
    assign r2=c&d;
    assign out=r1|r2;
    assign out_n=~(r1|r2);

endmodule
