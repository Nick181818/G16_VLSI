//
// Binary To Gray Convertor
//
module bin2gray
#(
  parameter ADDRSIZE = 8
)
(
    input [ADDRSIZE-1:0] bin_in, // Binary Value
    output [ADDRSIZE-1:0] gray_out // Converted Gray Value
    );
    
    genvar i;
    generate
    for (i = ADDRSIZE-2; i >= 0; i=i-1)
    begin : xor_gate
        xor (gray_out[i], bin_in[i+1], bin_in[i]);
    end
    endgenerate
    
    assign gray_out[ADDRSIZE-1] = bin_in[ADDRSIZE-1];
    
endmodule