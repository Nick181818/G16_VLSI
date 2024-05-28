module instruction_mux(
    input flush_in,
    input [31:0] instr_in,
    output [6:0] opcode_out,
    output [2:0] funct3_out,
    output [6:0] funct7_out,
    output [4:0] rs1_addr_in,
    output [4:0] rs2_addr_in,
    output [4:0] rd_addr_out,
    output [24:0] instr_31_7
);

reg [31:0] flush_out_logic = 32'h00000013;

assign opcode_out = (!flush_in) ? instr_in[6:0] : flush_out_logic[6:0];
assign funct3_out = (!flush_in) ? instr_in[14:12] : flush_out_logic[14:12];
assign funct7_out = (!flush_in) ? instr_in[31:25] : flush_out_logic[31:25];
assign rs1_addr_in = (!flush_in) ? instr_in[19:15] : flush_out_logic[19:15];
assign rs2_addr_in = (!flush_in) ? instr_in[24:20] : flush_out_logic[24:20];
assign rd_addr_out = (!flush_in) ? instr_in[11:7] : flush_out_logic[11:7];
assign instr_31_7 = (!flush_in) ? instr_in[31:7] : flush_out_logic[31:7];

endmodule