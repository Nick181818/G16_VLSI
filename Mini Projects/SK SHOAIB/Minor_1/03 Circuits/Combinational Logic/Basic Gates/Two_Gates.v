module top_module (
    input in1,
    input in2,
    input in3,
    output out);

    wire x;
    
    assign x=~(in1^in2);
    assign out=x^in3;

endmodule
