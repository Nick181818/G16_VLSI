module Gray2Binary 
    #(
        parameter S = 8
        )
(
  input [S-1:0] gray_in, //Gray In  
  output [S-1:0] bin_out //Binary Out  
    );
    
    genvar i;
    generate
      for (i = S-2; i >= 0; i=i-1)
    begin : xor_gate
        xor (bin_out[i], bin_out[i+1], gray_in[i]);
    end
    endgenerate
    
  assign bin_out[S-1] = gray_in[S-1];
    
endmodule