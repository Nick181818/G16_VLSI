module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
); 
    wire [31:0]w;
    wire cout;
    add16 ad0(.a(a[15:0]) , .b(w[15:0]) , .cin(sub), .sum(sum[15:0]),.cout(cout));
    add16 ad1(.a(a[31:16]) , .b(w[31:16]) , .cin(cout), .sum(sum[31:16]));
     assign w[31:0] = sub?~b:b;
endmodule
