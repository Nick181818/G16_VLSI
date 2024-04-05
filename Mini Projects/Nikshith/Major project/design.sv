`include "ALU_block.sv"
`include "branch_unit.sv"
`include "control_unit.sv"
`include "decoder_unit.sv"
`include "imm_adder.sv"
`include "imm_generator.sv"
`include "instr_mux.sv"
`include "load_unit.sv"
`include "PC_MUX.sv"
`include "reg_block.sv"
`include "reg_block2.sv"
`include "reg_file.sv"
`include "store_unit.sv"
`include "wb_mux.sv"
`include "wr_en_generator.sv"

module processor_top (
    input clk,
    input rst,
    input  [31:0] instr,
    output [31:0] iaddr, // For Instruction Memory

    input [31:0] dm_data_o,
    output [31:0] dm_data_in,
    output [31:0] dm_addr,
    output [31:0] dm_wr_mask,
    output dm_wr_req
);

    // Wire declarations
    wire [31:0] pc_mux, pc_plus_4, iaddr_imm, pc_in_reg1, imm_data, iadder_data;
    wire [2:0] fun_3;
    wire [6:0] fun_7;
    wire [24:0] instr_31_7;
    wire [6:0] opcode;
    wire [4:0] rs1_addr, rs2_addr, rd_addr;
    wire [31:0] rs1_data, rs2_data;
    wire [2:0] alu_opcode_reg2;
    wire alu_src_reg2;
    wire [31:0] iadder_out_reg2, imm_reg2, pc_plus_4_reg2;
    wire [1:0] load_size_reg2;
    wire load_unsigned_reg2;
    wire [4:0] rd_addr_reg2;
    wire rf_wr_en_reg2;
    wire [31:0] rs1_reg2, rs2_reg2;
    wire [2:0] wb_mux_sel_reg2;
    wire [31:0] result_alu, lu_output, alu_2nd_src_mux, wb_mux_o;
    wire wr_en_reg_file, branch_taken, flush;
    wire [1:0] pc_src;
    wire [2:0] wb_mux_sel, imm_type;
    wire mem_wr_req;
    wire [3:0] ALU_opcode;
    wire [1:0] load_size;
    wire load_unsigned;
    wire ALU_src, iadder_src, rf_wr_en;

    // Module instantiations
    PC_MUX pc_mux_unit (
        .rst_in(rst),
        .pc_src_in(pc_src),
        .pc_in(pc_in_reg1),
        .branch_taken_in(branch_taken),
        .iaddr_in(iaddr_imm),
        .pc_mux_o(pc_mux),
        .pc_plus_4_o(pc_plus_4),
        .iaddr_o(iaddr)
    );

    reg_block reg_block_unit (
        .pc_mux_in(pc_mux),
        .rst_in(rst),
        .clk_in(clk),
        .pc_o(pc_in_reg1)
    );

    imm_generator imm_gen_unit (
        .instr_in(instr_31_7),
        .imm_type_in(imm_type),
        .imm_o(imm_data)
    );

    imm_adder imm_adder_unit (
        .iadder_src(iadder_src),
        .pc_in(pc_in_reg1),
        .rs1_in(rs1_data),
        .imm_in(imm_data),
        .iadder_o(iadder_data)
    );

        reg_file reg_file_unit (
        .clk_in(clk),
        .rst_in(rst),
        .rs1_addr_in(rs1_addr),
        .rs2_addr_in(rs2_addr),
        .wr_in(rd_addr_reg2),
        .rd_data(wb_mux_o),
        .wr_en(wr_en_reg_file),
        .rs1_o(rs1_data),
        .rs2_o(rs2_data)
    );

    instr_mux instr_mux_unit (
        .flush_in(flush),
        .instr_in(instr),
        .opcode_o(opcode),
        .fun_3_o(fun_3),
        .fun_7_o(fun_7),
        .rs1_addr_o(rs1_addr),
        .rs2_addr_o(rs2_addr),
        .rd_addr_o(rd_addr),
        .instr_31_7_o(instr_31_7)
    );

    branch_unit branch_unit_unit (
        .rs1_in(rs1_data),
        .rs2_in(rs2_data),
        .opcode_6_2_in(opcode[6:2]),
        .fun_3_in(fun_3),
        .branch_taken_o(branch_taken)
    );

    control_unit control_unit_unit (
        .clk_in(clk),
        .rst_in(rst),
        .flush_o(flush),
        .pc_src_o(pc_src)
    );

    wr_en_generator wr_en_generator_unit (
        .wr_en_reg_in(rf_wr_en_reg2),
        .flush_in(flush),
        .wr_en_reg_file_o(wr_en_reg_file)
    );

    decoder_unit decoder_unit_unit (
        .fun_7_5_in(fun_7[5]),
        .fun_3_in(fun_3),
        .opcode_in(opcode),
        .wb_mux_sel_o(wb_mux_sel),
        .imm_type_o(imm_type),
        .mem_wr_req_o(mem_wr_req),
        .ALU_opcode_o(ALU_opcode),
        .load_size_o(load_size),
        .load_unsigned_o(load_unsigned),
        .ALU_src_o(ALU_src),
        .iadder_src_o(iadder_src),
        .wr_en_o(rf_wr_en)
    );

    store_unit store_unit_unit (
        .fun_3(fun_3),
        .iadder_in(iadder_data),
        .rs2_in(rs2_data),
        .mem_wr_req(mem_wr_req),
        .dm_data_o(dm_data_o),
        .dm_addr_o(dm_addr),
        .dm_wr_mask_o(dm_wr_mask),
        .dm_wr_req_o(dm_wr_req)
    );

    reg_block2 reg_block2_unit (
        .clk_in(clk),
        .rst_in(rst),
        .rd_addr_in(rd_addr),
        .rs1_in(rs1_data),
        .rs2_in(rs2_data),
        .pc_plus_4_in(pc_plus_4),
        .branch_taken_in(branch_taken),
        .iaddr_in(iadder_data),
        .alu_opcode_in(ALU_opcode),
        .load_size_in(load_size),
        .load_unsigned_in(load_unsigned),
        .ALU_src_in(ALU_src),
        .rf_wr_en(rf_wr_en),
        .wb_mux_sel_in(wb_mux_sel),
        .imm_in(imm_data),
        .rd_addr_reg_o(rd_addr_reg2),
        .rs1_reg_o(rs1_reg2),
        .rs2_reg_o(rs2_reg2),
        .pc_plus_4_reg_o(pc_plus_4_reg2),
        .iaddr_reg_o(iadder_out_reg2),
        .alu_opcode_reg_o(alu_opcode_reg2),
        .load_size_reg_o(load_size_reg2),
        .load_unsigned_reg_o(load_unsigned_reg2),
        .alu_src_reg_o(alu_src_reg2),
        .rf_wr_en_o(rf_wr_en_reg2),
        .wb_mux_sel_reg_o(wb_mux_sel_reg2),
        .imm_reg_o(imm_reg2)
    );

    load_unit load_unit_unit (
        .dm_data_in(dm_data_in),
        .iadder_out_1to0_in(iadder_out_reg2[1:0]),
        .load_unsigned_in(load_unsigned_reg2),
        .load_size_in(load_size_reg2),
        .load_output_o(lu_output)
    );

    ALU_block alu_block_unit (
        .op_1_in(rs1_reg2),
        .op_2_in(alu_2nd_src_mux),
        .opcode_in(alu_opcode_reg2),
        .result_o(result_alu)
    );

    wb_mux wb_mux_unit (
        .alu_src_reg_in(alu_src_reg2),
        .imm_reg_in(imm_reg2),
        .rs2_reg_in(rs2_reg2),
        .wb_mux_sel_reg_in(wb_mux_sel_reg2),
        .alu_result_in(result_alu),
        .load_output_in(lu_output),
        .iadder_out_reg_in(iadder_out_reg2),
        .pc_plus_4_reg_in(pc_plus_4_reg2),
        .alu_2nd_src_mux_o(alu_2nd_src_mux),
        .wb_mux_o(wb_mux_o)
);
endmodule

