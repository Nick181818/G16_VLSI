module top_module (input x, input y, output z);
    
    wire p,q,r,s,t,u;
    
    assign p=(x^y)&x;
    assign q=~(x^y);
    assign r=(x^y)&x;
    assign s=~(x^y);
    assign t=p|q;
    assign u=r&s;
    assign z=t^u;

endmodule
