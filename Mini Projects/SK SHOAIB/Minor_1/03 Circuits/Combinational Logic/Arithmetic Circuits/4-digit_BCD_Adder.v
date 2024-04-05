module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    
    wire [3:0]p,r,t,v;
    wire q,s,u;
    wire [15:0]w;
    
    bcd_fadd a1(.a(a[3:0]),.b(b[3:0]),.cin(cin),.sum(p),.cout(q));
    bcd_fadd a2(.a(a[7:4]),.b(b[7:4]),.cin(q),.sum(r),.cout(s));
    bcd_fadd a3(.a(a[11:8]),.b(b[11:8]),.cin(s),.sum(t),.cout(u));
    bcd_fadd a4(.a(a[15:12]),.b(b[15:12]),.cin(u),.sum(v),.cout(cout));
    
    assign w={v,t,r,p};
    assign sum=w;

endmodule
