wire h,g,l;
module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    add16 k1 (a[15:0],b[15:0],h,sum[15:0],g);
    add16 k2(a[31:16],b[31:16],g,sum[31:16],l);
endmodule