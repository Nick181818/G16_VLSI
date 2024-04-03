module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] p,r,s,t;
    wire q;

    add16 a1(.a(a[15:0]),.b(b[15:0]),.cin(1'b0),.sum(p),.cout(q));
    add16 a2(.a(a[31:16]),.b(b[31:16]),.cin(1'b0),.sum(r),.cout());
    add16 a3(.a(a[31:16]),.b(b[31:16]),.cin(1'b1),.sum(s),.cout());
    
    assign t=(q==1'b0)?r:s;
    assign sum={t,p};
    

endmodule
