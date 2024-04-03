module b2g #(parameter N = 8)(
  input [N-1:0] bin_in,
  output [N-1:0] gray_out
    );  
    genvar i;
    generate
    for (i = N-1; i > 0; i=i-1)
    begin
      xor (gray_out[i-1], bin_in[i], bin_in[i-1]);
    end
    endgenerate
  assign gray_out[N-1] = bin_in[N-1];
endmodule