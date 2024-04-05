module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire x;
    add16 ins1(.a(a[15:0]), .b(b[15:0]), .sum(sum[15:0]), .cout(x));
    add16 ins2(.a(a[31:16]), .b(b[31:16]), .sum(sum[31:16]), .cin(x));

endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

// Full adder module here
	assign sum=a^b^cin;
	assign cout=a&b|b&cin|cin&a;
endmodule
