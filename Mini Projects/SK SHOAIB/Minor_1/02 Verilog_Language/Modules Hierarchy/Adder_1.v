module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum);
    
    wire [15:0]p,r;
    wire q;
    wire [31:0]s;
    
    assign s={r,p};
    
    add16 a1(.a(a[15:0]),.b(b[15:0]),.cin(1'b0),.sum(p),.cout(q));
    add16 a2(.a(a[31:16]),.b(b[31:16]),.cin(q),.sum(r),.cout());
    assign sum=s;


endmodule
