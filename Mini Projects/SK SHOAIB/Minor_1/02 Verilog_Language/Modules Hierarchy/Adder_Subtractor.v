module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire p;
    wire [31:0]q;
    
    assign q = {32{sub}}^b; 
    add16 adder1(a[15:0],q[15:0],sub,sum[15:0],p);
    add16 adder2(a[31:16],q[31:16],p,sum[31:16],1'b0);
    

endmodule
