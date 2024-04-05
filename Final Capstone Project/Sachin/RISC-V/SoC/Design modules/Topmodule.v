module Topmodule(
    input clk,
    input rst,
    input [31:0] instr_in,
    output [31:0] imaddr_out,
    output [31:0] dmaddr_out,
    output [31:0] dmdata_out,
    output [3:0] dmwr_mask_out,
    output dmwr_req_out);

wire [31:0] pc_mux_out, pc_plus_4_out, i_addr_out, pc_out;
wire [31:0] imm_out;
wire [31:0] rs1_out, rs2_out;
wire [6:0] opcode_out;
wire [2:0] funct3_out;
wire [6:0] funct7_out;
wire [4:0] rs1_addr_in, rs2_addr_in, rd_addr_out;
wire branch_taken_out;
wire flush_out;
wire [1:0] pc_src_out;
wire wr_en_reg_file_out;
wire mem_wr_req_out;
wire [2:0] wb_mux_sel_out, imm_type_out;
wire [3:0] alu_opcode_out;
wire [1:0] load_size_out;
wire load_unsigned_out;
wire alu_src_out, iadder_src_out, rf_wr_en_out;
wire [31:0] alu_result_out, lu_output_out, iadder_out_reg_out;
wire [31:0] wb_mux_out;
wire [31:0] alu_2_src_mux_out;
wire [24:0] instr_31_7;

pc_mux pc_mux_inst(
    .rst_in(rst),
    .pc_src_in(pc_src_out),
    .pc_in(pc_out),
    .branch_taken_in(branch_taken_out),
    .iaddr_in(i_addr_out[30:0]),
    .pc_mux_out(pc_mux_out),
    .pc_plus_4_out(pc_plus_4_out),
    .i_addr_out(i_addr_out)
);

reg_block_1 reg_block_1_inst(
    .clk(clk),
    .rst_in(rst),
    .pc_mux_in(pc_mux_out),
    .pc_out(pc_out)
);

immediate_generator immediate_generator_inst(
    .instr_in(instr_in[31:7]),
    .imm_type_in(imm_type_out),
    .imm_out(imm_out)
);

immediate_adder immediate_adder_inst(
    .pc_in(pc_out),
    .rs1_in(rs1_out),
    .imm_in(imm_out),
    .iaddr_src(iadder_src_out),
    .iaddr_out(i_addr_out)
);

reg_file reg_file_inst(
    .clk_in(clk),
    .rst_in(rst),
    .rs1_addr_in(rs1_addr_in),
    .rs2_addr_in(rs2_addr_in),
    .rd_addr_in(rd_addr_out),
    .rd_data(wb_mux_out),
    .wr_en_in(wr_en_reg_file_out),
    .rs1_out(rs1_out),
    .rs2_out(rs2_out)
);

instruction_mux instruction_mux_inst(
    .flush_in(flush_out),
    .instr_in(instr_in),
    .opcode_out(opcode_out),
    .funct3_out(funct3_out),
    .funct7_out(funct7_out),
    .rs1_addr_in(rs1_addr_in),
    .rs2_addr_in(rs2_addr_in),
    .rd_addr_out(rd_addr_out),
    .instr_31_7(instr_31_7)
);

branch_unit branch_unit_inst(
    .rs1_in(rs1_out),
    .rs2_in(rs2_out),
    .opcode_6_2_in(opcode_out[6:2]),
    .funct3_in(funct3_out),
    .branch_taken_out(branch_taken_out)
);

control_unit control_unit_inst(
    .clk_in(clk),
    .rst_in(rst),
    .flush_out(flush_out),
    .pc_src_out(pc_src_out)
);

write_enable_gen write_enable_gen_inst(
    .wr_en_reg_in(rf_wr_en_out),
    .flush_in(flush_out),
    .wr_en_reg_file_out(wr_en_reg_file_out)
);

decoder decoder_inst(
    .funct7_5_in(funct7_out[5]),
    .opcode_in(opcode_out[6:2]),
    .funct3_in(funct3_out),
    .wb_mux_sel_out(wb_mux_sel_out),
    .imm_type_out(imm_type_out),
    .mem_wr_req_out(mem_wr_req_out),
    .alu_opcode_out(alu_opcode_out),
    .load_size_out(load_size_out),
    .load_unsigned_out(load_unsigned_out),
    .alu_src_out(alu_src_out),
    .iadder_src_out(iadder_src_out),
    .rf_wr_en_out(rf_wr_en_out)
);

store_unit store_unit_inst(
    .mem_wr_req(mem_wr_req_out),
    .func3(funct3_out),
    .iadder_in(iadder_out_reg_out),
    .rs2_in(rs2_out),
    .dmwr_mask_out(dmwr_mask_out),
    .dmdata_out(dmdata_out),
    .dmaddr_out(dmaddr_out),
    .dmwr_req_out(dmwr_req_out)
);

reg_block_2 reg_block_2_inst(
    .clk_in(clk),
    .reset_in(rst),
    .rd_addr_in(rd_addr_out),
    .rs1_in(rs1_out),
    .rs2_in(rs2_out),
    .pc_in(pc_out),
    .pc_plus_4_in(pc_plus_4_out),
    .branch_taken_in(branch_taken_out),
    .iadder_in(i_addr_out),
    .alu_opcode_in(alu_opcode_out),
    .load_size_in(load_size_out),
    .load_unsigned_in(load_unsigned_out),
    .alu_src_in(alu_src_out),
    .rf_wr_en_in(rf_wr_en_out),
    .wb_mux_sel_in(wb_mux_sel_out),
    .imm_in(imm_out),
    .rd_addr_reg_out(rd_addr_out),
    .rs1_reg_out(rs1_out),
    .rs2_reg_out(rs2_out),
    .pc_reg_out(pc_out),
    .pc_plus_4_reg_out(pc_plus_4_out),
    .iadder_out_reg_out(iadder_out_reg_out),
    .alu_opcode_reg_out(alu_opcode_out),
    .load_size_reg_out(load_size_out),
    .load_unsigned_reg_out(load_unsigned_out),
    .alu_src_reg_out(alu_src_out),
    .rf_wr_en_reg_out(rf_wr_en_out),
    .wb_mux_sel_reg_out(wb_mux_sel_out),
    .imm_reg_out(imm_out)
);

load_unit load_unit_inst(
    .dmdata_in(dmdata_out),
    .iaddr_out_1_to_0_in(iadder_out_reg_out[1:0]),
    .load_unsigned_in(load_unsigned_out),
    .load_size_in(load_size_out),
    .lu_output_out(lu_output_out)
);

wb_mux wb_mux_inst(
    .ALU_src_reg_in(alu_src_out),
    .imm_reg_in(imm_out),
    .rs2_reg_in(rs2_out),
    .wb_mux_sel_reg_in(wb_mux_sel_out),
    .ALU_result_in(alu_result_out),
    .lu_output_in(lu_output_out),
    .iadder_out_reg_in(iadder_out_reg_out),
    .pc_plus_4_reg_in(pc_plus_4_out),
    .alu_2_src_mux_out(alu_2_src_mux_out),
    .wb_mux_out(wb_mux_out)
);

ALU ALU_inst(
    .op_1_in(rs1_out),
    .op_2_in(alu_2_src_mux_out),
    .opcode_in(alu_opcode_out),
    .result_out(alu_result_out)
);

endmodule
