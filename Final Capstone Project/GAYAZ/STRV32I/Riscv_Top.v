// Code your design here
`include "ALU_unit.sv"
`include "branch_unit.sv"
`include "control_unit.sv"
`include "decoder_unit.sv"
`include "immediate_adder.sv"
`include "immediate_generator.sv"
`include "instruction_mux.sv"
`include "load_unit.sv"
`include "pc_unit.sv"
`include "reg_block_1.sv"
`include "reg_block_2.sv"
`include "reg_file.sv"
`include "store_unit.sv"
`include "wb_mux.sv"
`include "write_enable_generator.sv"

module Riscv_Top(
     input clk_in,
     input rst_in,
     input [31:0] dm_data_in,
     input  [31:0] instr,
     output [31:0] iaddr,
     output [31:0] dm_data_out,
     output [31:0] dm_addr,
     output [3:0] dm_wr_mask,
     output [31:0]dm_wr_req
     );
 

    wire [31:0] pc_mux;
    wire [31:0] pc_plus_4;
    wire [31:0] iaddr_imm;
    wire [31:0] pc_in_reg1;
    wire  imm_data;
    wire [31:0] iadder_data;
    wire [2:0] func3;
    wire [6:0] func7;
    wire [31:0] instr_31_7;
    wire [4:0] opcode;
    wire [4:0] rs1_addr;
    wire [4:0] rs2_addr;
    wire [4:0] rd_addr;
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    wire [3:0] alu_opcode_reg2;
    wire alu_src_reg2;
    wire [31:0] iadder_out_reg2;
    wire  imm_reg2;
    wire [1:0] load_size_reg2;
    wire load_unsigned_reg2;
    wire [31:0] pc_plus_4_reg2;
    wire [4:0] rd_addr_reg2;
    wire rf_wr_en_reg2;
    wire [31:0] rs1_reg2;
    wire [31:0] rs2_reg2;
    wire [2:0] wb_mux_sel_reg2;
    wire [31:0] result_alu;
    wire [31:0] load_output;
    wire [31:0] dm_data_out1;
    assign dm_data_out = dm_data_out1;
    wire [31:0] alu_2nd_src_mux;
    wire [31:0] wb_mux_out; 
    wire wr_en_reg_file;
    wire branch_taken;
    wire flush;
    wire [1:0] pc_src;
    wire [2:0] wb_mux_sel;
    wire [2:0] imm_type;
    wire mem_wr_req;
    wire [3:0] ALU_opcode;
    wire [1:0] load_size;
    wire load_unsigned;
    wire ALU_src;
    wire iadder_src;
    wire rf_wr_en;

//Instantiate pc_unit
    pc_unit pc_unit (
     .rst_in(rst_in),
     .pc_src_in(pc_src),
     .pc_in(pc_in_reg1),
     .branch_take_in(branch_taken),
     .iaddr_in(iaddr_imm),
     .pc_mux_out(pc_mux),
     .pc_plus_4_out(pc_plus_4),
     .iaddr_out(iaddr)
 );
     
//Instantiate reg_block_1
 reg_block_1 reg_block_1 (
     .pc_mux_in(pc_mux),
     .rst_in(rst_in),
     .clk_in(clk_in),
     .pc_mux_out1(pc_in_reg1)
 );

//Instantiate reg_file
reg_file reg_file(
     .clk_in(clk_in),
     .rst_in(rst_in),
     .rs1_adder_in(rs1_addr),
     .rs2_adder_in(rs2_addr),
     .rd_adder_in(rd_addr_reg2),
     .rd_data(wb_mux_out),
     .wr_en_in(wr_en_reg_file),
     .rs1_out(rs1_data),
     .rs2_out(rs2_data)
     );
//Instantiate alu_unit
ALU_unit alu_unit(
     .op_1_in(rs1_reg2),
     .op_2_in(alu_2nd_src_mux),
     .opcode_in(alu_opcode_reg2),
     .result_out(result_alu)
    );

//Instantiate Branch_unit
branch_unit branch_unit(
     .rs1_in(rs1_data),
     .rs2_in(rs2_data),
     .opcode_6_2_in(opcode[4:0]),
     .func3_in(func3),
     .branch_taken_out(branch_taken)
    );

//Instantiate Control_unit
control_unit control_unit(
     .clk_in(clk_in),
     .rst_in(rst_in),
     .flush_out(flush),
     .pc_src_out(pc_src)
    );

//Instantiate Decoder_unit
decoder_unit decoder_unit(
     .func_7_5_in(func7[5]),
     .func_3_in(func3),
     .opcode_in(opcode),
     .wb_mux_sel_out(wb_mux_sel),
     .imm_type_out(imm_type),
     .mem_wr_req_out(mem_wr_req),
     .ALU_opcode_out(ALU_opcode),
     .load_size_out(load_size),
     .load_unsigned_out(load_unsigned),
     .ALU_src_out(ALU_src),
     .iadder_src_out(iadder_src),
     .wr_en_out(rf_wr_en)
     );

//Instantite Imm_Adder
immediate_adder immediate_adder(
     .pc_in(pc_in_reg1),
     .rs1_in(rs1_data),
     .immd_in(imm_data),
     .iadder_src(iadder_src),
     .iadder_out(iadder_data)
     );  

//Instantiate Imm_gen
immediate_generator immediate_generator (
     .instr_in(instr_31_7),
     .imm_type_in(imm_type),
     .imm_out(imm_data)
     );

//Instantiate Inst_Mux
instruction_mux instruction_mux(
     .flush_in(flush),
     .instr_in(instr),
     .opcode_out(opcode),
     .func3_out(func3),
     .func7_out(func7),
     .rs1_addr_out(rs1_addr),
     .rs2_addr_out(rs2_addr),
     .rd_addr_out(rd_addr),
     .instr_31_7_out(instr_31_7)
    );

//Instantiate Load_unit
load_unit load_unit(
     .dm_data_in(dm_data_in),
     .iadder_out_1to0_in(iadder_out_reg2[1:0]),
     .load_unsigned_in(load_unsigned_reg2),
     .load_size_in(load_size_reg2),
     .load_output_o(load_output)
    );

store_unit store_unit(
     .func3(func3),
     .iadder_in(iadder_data),
     .rs2_in(rs2_data),
     .mem_wr_req(mem_wr_req),
     .dm_data_out(dm_data_out1),
     .dm_addr_out(dm_addr),
     .dm_wr_mask_out(dm_wr_mask),
     .dm_wr_req_out(dm_wr_req)
    );

wb_mux wb_mux(
     .alu_src_reg_in(alu_src_reg2),
     .imm_reg_in(imm_reg2),
     .rs2_reg_in(rs2_reg2),
     .wb_mux_sel_reg_in(wb_mux_sel_reg2),
     .alu_result_in(result_alu),
     .load_output_in(load_output),
     .iadder_out_reg_in(iadder_out_reg2),
     .pc_plus_4_reg_in(pc_plus_4_reg2),
     .alu_2nd_src_mux_out(alu_2nd_src_mux),
     .wb_mux_out(wb_mux_out)
     );

write_enable_generator  wr_en_gen(
     .wr_en_g_in(rf_wr_en_reg2),
     .flush_in(flush),
     .wr_en_g_file_out(wr_en_reg_file)
     );

reg_block_2 reg_block_2(
     .clk_in(clk_in),
     .rst_in(rst_in),
     .rd_adder_in(rd_addr),
     .rs1_in(rs1_data),
     .rs2_in(rs2_data),
     .pc_in(pc_in_reg1),
     .pc_plus_4_in(pc_plus_4),
     .branch_taken_in(branch_taken),
     .iadder_in(iadder_data),
     .alu_opcode_in(ALU_opcode),
     .load_size_in(load_size),
     .load_unsigned_in(load_unsigned),
     .alu_src_in(ALU_src),
     .rf_wr_en(rf_wr_en),
     .wb_mux_sel_in(wb_mux_sel),
     .imm_in(imm_data),
     
     .rd_adder_reg_out(rd_addr_reg2),
     .rs1_reg_out(rs1_reg2),
     .rs2_reg_out(rs2_reg2),
     .pc_plus_4_reg_out(pc_plus_4_reg2),
     .pc_reg_out(pc_in_reg1),
     .iadder_out_reg_out(iadder_out_reg2),
     .alu_opcode_reg_out(alu_opcode_reg2),
     .load_size_reg_out(load_size_reg2),
     .load_unsigned_reg_out(load_unsigned_reg2),
     .alu_src_reg_out(alu_src_reg2),
     .rf_wr_en_reg_out(rf_wr_en_reg2),
     .wb_mux_sel_reg_out(wb_mux_sel_reg2),
     .imm_reg_out(imm_reg2)
    );
endmodule