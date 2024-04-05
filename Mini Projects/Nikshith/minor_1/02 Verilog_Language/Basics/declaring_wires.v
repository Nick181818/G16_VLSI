`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
wire wire1,wire2;
assign wire1=a&b;
assign wire2=c&d; 
assign out=wire1|wire2;
    assign out_n=!(out);
endmodule