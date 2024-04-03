module top_module (
    input in1,
    input in2,
    input in3,
    output out);
wire A;
    assign  A = ~(in1 ^ in2);
    assign  out = A ^ in3;
endmodule