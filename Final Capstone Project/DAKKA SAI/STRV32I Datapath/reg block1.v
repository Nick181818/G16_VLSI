module reg_block(
  input rst_in,
  input clk_in,
  input [31:0] pc_mux_in,
  output reg [31:0] pc_o 
);
  
  always@(posedge clk_in)
    begin 
      if(rst_in) 
        pc_o<=32'h0;
      else 
        pc_o<=pc_mux_in;
    end 
endmodule