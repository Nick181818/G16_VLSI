module g2b#(parameter d=8)(
  
  input [d-1:0] gray,
  output [d-1:0] binary
);
    
    genvar i;
  
    generate
    for(i=0;i<d-1;i=i+1) 
      begin
        xor(binary[i],binary[i+1],gray[i]);
      end
  endgenerate
  
  assign binary[d-1] = gray[d-1];
  
endmodule
