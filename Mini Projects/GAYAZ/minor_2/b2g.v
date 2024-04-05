module b2g #(parameter N = 8)(
    input [N-1:0] binaryIn,
    output [N-1:0] grayOut
    );
    
    genvar i;
    generate
    for (i = N-1; i > 0; i=i-1)
    begin : xor_tag
        xor (grayOut[i-1], binaryIn[i], binaryIn[i-1]);
    end
    endgenerate
    
    assign grayOut[N-1] = binaryIn[N-1];
    
endmodule