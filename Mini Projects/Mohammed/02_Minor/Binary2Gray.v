module Binary2Gray
    #(
        parameter S = 8
        )
(
  input [S-1:0] bin_in, //Binary In  
  output [S-1:0] gray_out //Gray Out  
    );
    
    genvar i;
    generate
      for (i = S-2; i >= 0; i=i-1)
    begin : xor_gate
        xor (gray_out[i], bin_in[i+1], bin_in[i]);
    end
    endgenerate
    
  assign gray_out[S-1] = bin_in[S-1];
    
endmodule