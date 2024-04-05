module g2b#(parameter N =8)(
    input [N-1:0] grayIn,
    output [N-1:0] binaryOut
    );
    
    genvar i;
    generate
    for (i = N-1; i > 0; i=i-1)
    begin : xor_tag
        xor (binaryOut[i-1], binaryOut[i], grayIn[i-1]);
    end
    endgenerate
    
    assign binaryOut[N-1] = grayIn[N-1];
    
endmodule