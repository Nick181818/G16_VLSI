module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    wire [31:0] c;
    wire cout0, cout1;

    always @(*) begin
        if (sub == 0) c = {32{sub}} + b +0;
        else c = {32{sub}} + ~b +1;
    end

    add16 adder0(.a(a[15:0]), .b(c[15:0]), .cin(sub), .sum(sum[15:0]), .cout(cout0));
    add16 adder1(.a(a[31:16]), .b(c[31:16]), .cin(cout0), .sum(sum[31:16]), .cout(cout1));

endmodule
