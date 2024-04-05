module top_module (
    input in1,
    input in2,
    input in3,
    output out);
wire p;
    assign p=~(in1 ^ in2);
    assign out=(p^in3);
endmodule