module imm_adder(
  
  input iadder_src,
  input [31:0] pc_in,
  input [31:0] rs1_in,
  input [31:0] imm_in,
  output [31:0] iadder_out
  
);
  
  wire [31:0] adder_out;
  
  assign adder_out  = (iadder_src == 1'b0)? pc_in : rs1_in;
  assign iadder_out = adder_out + imm_in;
  
endmodule
