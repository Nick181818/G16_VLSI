module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//
    wire c;
    wire [15:0]s1, s2,a1, a2, b1, b2;
    assign  a1 = a[15:0],
        a2 = a[31:16],
        b1 = b[15:0],
        b2 = b[31:16];
    add16 u1 (.a(a1), .b(b1), .cin(1'b0), .sum(s1), .cout(c));
    add16 u2 (.a(a2), .b(b2), .cin(c), .sum(s2));
    assign sum = {s2,s1};

endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );
 	assign sum = a^b^cin;
    assign cout = ( (a&b) | (b&cin) | (cin&a) );
// Full adder module here

endmodule