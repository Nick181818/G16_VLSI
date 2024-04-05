module wr_en_generator( 
  input wr_en_reg_in,
  input flush_in,
  output reg wr_en_reg_file_o
);

  always @* begin
    if (flush_in)
      wr_en_reg_file_o = 1'b0;
    else
      wr_en_reg_file_o = wr_en_reg_in;
  end

endmodule
