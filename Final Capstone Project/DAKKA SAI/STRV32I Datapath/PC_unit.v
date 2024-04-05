module PC_MUX(
    input rst_in,
    input [1:0] pc_src_in,
    input [31:0] pc_in,
    input [30:0]iaddr_in,
    input branch_taken_in,
    output [31:0] pc_mux_o,
    output [31:0] pc_plus_4_o,
    output [31:0] iaddr_o
    
);
  wire [31:0] up_pc_plus_4;
  wire [31:0] next_pc;
  reg  [31:0]  up_pc_mux;

  assign up_pc_plus_4 = pc_in + 32'h0000_0004; // Next program counter value

  assign next_pc = branch_taken_in ? {iaddr_in,1'b0} : up_pc_plus_4;

  always @(*) 
  begin
    case(pc_src_in)
    2'b00 : up_pc_mux = 32'h0000_0000; // Boot Address
    2'b11 : up_pc_mux = next_pc;
    default : up_pc_mux = next_pc;
    endcase
  end
  
  assign iaddr_o = rst_in ? 32'h0000_0000 : up_pc_mux;
  assign pc_plus_4_o = up_pc_plus_4;
  assign pc_mux_o = up_pc_mux;
endmodule