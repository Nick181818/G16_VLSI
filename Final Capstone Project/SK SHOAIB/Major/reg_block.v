module reg_block_1(
  
  input rst_in,
  input clk_in,
  input [31:0] pc_mux_in,
  output reg [31:0] pc_out
  
);
  
  always@(posedge clk_in)
    begin 
      if(rst_in) 
        pc_out<=32'h0;
      else 
        pc_out<=pc_mux_in;
    end 
  
endmodule
  
