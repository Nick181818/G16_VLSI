module b2g #(parameter d= 8)(
  
  input [d-1:0] binary,
  output [d-1:0] gray
);
    
  genvar i;
  
  generate
    for(i=0;i<d-1;i=i+1) 
      begin
       xor (gray[i],binary[i], binary[i+1]);
      end
  endgenerate
  
  assign gray[d-1] = binary[d-1];
  
endmodule
