module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);
    
    assign min=((a<b)&(a<c)&(a<d))?a:((b<c)&(b<d))?b:(c<d)?c:d;


endmodule
