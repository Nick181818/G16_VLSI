module g2b#(parameter N =8)(
  input [N-1:0] gray_in,
  output [N-1:0] bin_out
    );   
    genvar i;
    generate
    for (i = N-1; i > 0; i=i-1)
    begin 
      xor (bin_out[i-1], bin_out[i], gray_in[i-1]);
    end
    endgenerate   
  assign bin_out[N-1] = gray_in[N-1];  
endmodule