module top_module (
  input [31:0] a,
  input [31:0] b,
  output [31:0] sum
);
    wire cout1, cout2;
    add16 lower_adder(.a(a[15:0]), .b(b[15:0]), .cin(1'b0), .sum(sum[15:0]), .cout(cout1));
    add16 upper_adder(.a(a[31:16]), .b(b[31:16]), .cin(cout1), .sum(sum[31:16]), .cout(cout2));

    assign sum = {upper_adder.sum, lower_adder.sum};

endmodule

module add1 (input a, input b, input cin, output sum, output cout);
  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (b & cin) | (cin & a);
endmodule

//module add16 (input [15:0] a, input [15:0] b, input cin, output [15:0] sum, output cout);
  //add1 FA[15:0] (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));
//endmodule
