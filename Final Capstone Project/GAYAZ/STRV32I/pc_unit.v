module pc_unit(
  input   rst_in, // Rese
  input   [1:0] pc_src_in,
  input   [31:0] pc_in,
  input   branch_take_in,
  input   [31:0] iaddr_in,
  output  [31:0] pc_mux_out,
  output  [31:0] pc_plus_4_out,
  output  [31:0] iaddr_out
);

  wire [31:0] temp_pc_plus_4;
  wire [31:0] next_pc;
  reg [31:0] temp_pc_mux;

  assign temp_pc_plus_4 = pc_in + 32'h00000004; // Next program counter value

  assign next_pc = branch_take_in ? {iaddr_in,1'b0} : temp_pc_plus_4;

  always @(*) 
  begin
    case(pc_src_in)
    2'b00 : temp_pc_mux = 32'h00000000; // Boot Address
    2'b11 : temp_pc_mux = next_pc;
    default : temp_pc_mux = next_pc;
    endcase
  end

  assign iaddr_out = rst_in ? 32'h00000000 : temp_pc_mux;
  assign pc_plus_4_out =  temp_pc_plus_4;
  assign pc_mux_out = temp_pc_mux;

endmodule