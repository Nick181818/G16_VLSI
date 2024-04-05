module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
wire d,e,f,g;
    assign d=p1a&p1b&p1c;
    assign e=p1f&p1d&p1e;
    assign p1y=d|e;
    assign f=p2a&p2b;
    assign g=p2c&p2d;
    assign 
        p2y=f|g;

endmodule