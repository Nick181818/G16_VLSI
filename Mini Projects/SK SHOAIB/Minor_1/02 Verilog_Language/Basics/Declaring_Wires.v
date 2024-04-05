`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   );
     
    wire p,q,r;
    assign p=a&b;
    assign q=c&d;
    assign r=p|q;
    assign out=r;
    assign out_n=~r;

endmodule
