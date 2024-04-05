module wr_en_generator( 
  input wr_en_reg_in,
  input flush_in,
  output wr_en_reg_file_o
);  
  assign wr_en_reg_file_o = (flush_in)? 1'b0 : wr_en_reg_in;
endmodule