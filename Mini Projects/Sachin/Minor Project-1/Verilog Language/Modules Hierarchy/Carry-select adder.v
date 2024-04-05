module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cout1;
    wire [15:0] sum1, sum2;
    //wire [31:16] sum3;

    add16 adder0 (.a(a[15:0]), .b(b[15:0]), .cin(0), .cout(cout1), .sum(sum[15:0]));
    add16 adder1 (.a(a[31:16]), .b(b[31:16]), .cin(0), .cout(), .sum(sum1));
    add16 adder2 (.a(a[31:16]), .b(b[31:16]), .cin(1), .cout(), .sum(sum2));

   

    always @(a or b or cout1) begin
        case (cout1)
            1'b0: sum[31:16] = sum1[15:0];
            1'b1: sum[31:16] = sum2[15:0];
            default: sum[31:16] = 16'b0;
        endcase
    end
endmodule
   /* assign sum = {sum0, sum3};


module mux2to1_16bit(
    input [15:0] sum1, sum2,
    input cout1,
    output [15:0] sum3
);

    always @(*) begin
        case (cout1)
            1'b0: sum3 = sum1;
            1'b1: sum3 = sum2;
            default: sum3 = 16'b0;
        endcase
    end

endmodule
*/