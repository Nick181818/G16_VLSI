module imm_adder( 
  input iadder_src,
  input [31:0] pc_in,
  input [31:0] rs1_in,
  input [31:0] imm_in,
  output reg [31:0] iadder_o  
); 

  reg [31:0] adder_o;

  always @* begin
    if (iadder_src == 1'b0)
      adder_o = pc_in;
    else
      adder_o = rs1_in;
  end

  always @* begin
    iadder_o = adder_o + imm_in;
  end

endmodule
