module immediate_adder(
  input [31:0] pc_in,
  input [31:0] rs1_in,
  input [31:0] immd_in,
  input iadder_src,
  output [31:0] iadder_out
);

   wire [0:31] out;
assign out = iadder_src ? pc_in :rs1_in;

assign iadder_out = out + immd_in;

endmodule