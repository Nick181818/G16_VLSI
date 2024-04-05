`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    wire h,i;
  assign    h=(a&b);
    assign i=(c&d);
    assign out=(h|i);
    assign out_n=~out;
endmodule