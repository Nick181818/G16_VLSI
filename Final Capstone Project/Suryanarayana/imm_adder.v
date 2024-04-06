module imm_adder( 
  input iadder_src,
  input [31:0] pc_in,
  input [31:0] rs1_in,
  input [31:0] imm_in,
  output [31:0] iadder_o  
); 
  wire [31:0] adder_o;
  assign adder_o = (iadder_src == 1'b0)? pc_in : rs1_in;
  assign iadder_o = adder_o + imm_in;
endmodule