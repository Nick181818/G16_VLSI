//
//Gray To Binary Convertor
//
module gray2bin #(parameter ADDRSIZE = 8)(
    input [ADDRSIZE-1:0] gray_in, // Gray Value
    output [ADDRSIZE-1:0] bin_out // Converted Binary value
    );
    
    genvar i;
    generate
      for (i = ADDRSIZE-2; i >= 0; i=i-1)
    begin : xor_gate
        xor (bin_out[i], bin_out[i+1], gray_in[i]);
    end
    endgenerate
    
    assign bin_out[ADDRSIZE-1] = gray_in[ADDRSIZE-1];
    
endmodule