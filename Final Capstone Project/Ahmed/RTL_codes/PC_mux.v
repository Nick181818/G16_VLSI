//
// Next Program Counter value Generator
//
module PC_mux(
  input   rst_in,                 // Reset
  input   [1:0] pc_src_in,        // Decides Program Counter Source
  input   [31:0] pc_in,           // Program Counter Value
  input   branch_taken_in,        // Branch taken signal
  input   [30:0] iaddr_in,        // Immediate Adder input
  output  [31:0] pc_mux_out,      // Output value
  output  [31:0] pc_plus_4_out,   // Program counter + 4 
  output  [31:0] iaddr_out        // Immediate Adder output
);

  wire [31:0] temp_pc_plus_4;
  wire [31:0] next_pc;
  reg [31:0] temp_pc_mux;

  assign temp_pc_plus_4 = pc_in + 32'h0000_0004; // Next program counter value

  assign next_pc = branch_taken_in ? {iaddr_in,1'b0} : temp_pc_plus_4;

  always @(*) 
  begin
    case(pc_src_in)
    2'b00 : temp_pc_mux = 32'h0000_0013; // Boot Address
    2'b11 : temp_pc_mux = next_pc;
    default : temp_pc_mux = next_pc;
    endcase
  end

  assign iaddr_out = rst_in ? 32'h0000_0000 : temp_pc_mux;
  assign pc_plus_4_out =  temp_pc_plus_4;
  assign pc_mux_out = temp_pc_mux;

endmodule