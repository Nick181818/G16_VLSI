module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
wire cout_sel;
    wire [15:0]sum0,sum1;
    
    add16 ad0(.a(a[15:0]), .b(b[15:0]), .cin(0), .cout(cout_sel), .sum(sum[15:0]) );
    add16 ad1(.a(a[31:16]), .b(b[31:16]), .cin(0), .sum(sum0[15:0]) );
    add16 ad2(.a(a[31:16]), .b(b[31:16]), .cin(1), .sum(sum1[15:0]) );
    
    assign sum[31:16] = cout_sel?sum1[15:0]:sum0[15:0];
endmodule
