module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0]p,r;
    wire q,s,t;
    
    
    add16 a1(a[15:0],b[15:0],t,p,q);
    add16 a2(a[31:16],b[31:16],q,r,s);
    assign sum={r,p};

endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

    assign sum=a^b^cin;
    assign cout=(cin&(a^b))|a&b;
    
endmodule
