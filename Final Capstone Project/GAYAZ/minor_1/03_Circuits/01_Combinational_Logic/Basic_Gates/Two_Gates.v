module top_module (
    input in1,
    input in2,
    input in3,
    output out);
    wire x;
    
    xnor x1(x,in1,in2);
    xor x2(out,in3,x);

endmodule
