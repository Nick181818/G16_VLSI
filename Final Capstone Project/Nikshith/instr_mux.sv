module instr_mux(
  input flush_in,
  input [31:0] instr_in,
  output reg [6:0] opcode_o,
  output reg [2:0] fun_3_o,
  output reg [6:0] fun_7_o,
  output reg [4:0] rs1_addr_o,
  output reg [4:0] rs2_addr_o,
  output reg [4:0] rd_addr_o,
  output reg [24:0] instr_31_7_o
);

  always @* begin
    if (flush_in) begin
      opcode_o     = 7'b0011; 
      fun_3_o      = 3'b000;
      fun_7_o      = 7'b0000000;
      rs1_addr_o   = 5'b00000;
      rs2_addr_o   = 5'b00000;
      rd_addr_o    = 5'b00000;
      instr_31_7_o = 25'b00000000000000000000000;
    end else begin
      opcode_o     = instr_in[6:0];
      fun_3_o      = instr_in[14:12];
      fun_7_o      = instr_in[31:25];
      rs1_addr_o   = instr_in[19:15];
      rs2_addr_o   = instr_in[24:20];
      rd_addr_o    = instr_in[11:7];
      instr_31_7_o = instr_in[31:7];
    end
  end

endmodule
