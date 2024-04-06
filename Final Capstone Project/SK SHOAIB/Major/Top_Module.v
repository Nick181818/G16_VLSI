`include "reg_block.v"
`include "imm_adder.v"
`include "write_gen.v"
`include "instruct_mux.v"
`include "Control_unit.v"
`include "Store.v"
`include "reg_block_2.v"
`include "Branch_unit.v"
`include "imm_gen.v"
`include "load_unit.v"
`include "ALU.v"
`include "WB_MUX.v"
`include "reg_file.v"
`include "decoder.v"
`include "pc_mux.v"



module top(
  
  input clk,
  input rst,
  input [31:0] instr_in,
  input [31:0] dm_data_in,
  output [3:0] dm_wr_mask_out,
  output [31:0] dm_addr_out,
  output [31:0] dm_data_out,
  output [31:0] im_addr_out,
  output dm_wr_req_out
 
);
  // PC_MUX Signals
  wire [31:0] temp_pc_mux_out; 
  wire [31:0] pc_plus_4;
  
  // Reg_Block_1
  wire [31:0] temp_pc_out;

  // Immediate_Gen
   
  wire [31:0] temp_imm_out;
  
  
  // Immediate Adder
  wire [31:0] temp_iadder_out;
  
  //Branch unit
  wire branch_taken;
  
    
  // Reg File
  wire [31:0] temp_rs1_out;
  wire [31:0] temp_rs2_out;
  
  
  // from write gen
  wire temp_wr_en_reg_out;
    
  
  // from instruction mux
  wire [6:0] opcode;
  wire [6:0] func7;
  wire [2:0] func3;
  wire [4:0] temp_rs1_addr_out; 
  wire [4:0] temp_rs2_addr_out; 
  wire [4:0] temp_rd_addr_out; 
  wire [24:0] instr_in_2; 
  
  // from Control unit
  wire temp_flush_out; 
  wire [1:0] pc_src;
  
  // from Store unit
  
  // from Decoder
  wire [2:0] temp_wb_mux_sel_out;
  wire [2:0] temp_imm_type_out;    
  wire temp_mem_wr_req;
  wire [3:0] temp_alu_opcode_out;
  wire [1:0] temp_load_size_out;
  wire temp_load_unsigned_out;
  wire temp_alu_src_out;
  wire temp_iadder_src_out; 
  wire temp_wr_en_out; 
  
  // from reg block 2
  wire [31:0] temp_iadder_out_reg;
  wire [4:0] temp_rd_adder_reg;
  wire [31:0] temp_rs1_reg;
  wire [31:0] temp_rs2_reg;
  wire [31:0] temp_pc_plus_4_reg;
  wire [3:0] temp_alu_opcode_reg;
  wire [1:0] temp_load_size_reg; 
  wire temp_load_unsigned_reg;
  wire temp_alu_src_reg;
  wire [2:0] temp_wb_mux_sel_reg_out; 
  wire [31:0] temp_imm_reg;
  wire temp_wr_en_reg;
  
  // from ALU unit
  wire [31:0] temp_alu_result;
  
  // from Load unit
  wire [31:0] temp_load_output;
  
  // from wb mux   
  wire [31:0] alu_2nd_src;
  wire [31:0] temp_wb_mux_out;
 
  
  // PC Unit  
  PC_MUX pc(
    .rst_in(rst),
    .branch_taken_in(branch_taken),
    .pc_src_in(pc_src),
    .pc_in(temp_pc_out),
    .iaddr_in(temp_iadder_out[31:1]),
    .pc_mux_out(temp_pc_mux_out),
    .pc_plus_4_out(pc_plus_4),
    .i_addr_out(im_addr_out)
  );
  
  
  // Reg Block
  reg_block_1 re(
    .clk_in(clk),
    .rst_in(rst),
    .pc_mux_in(temp_pc_mux_out),
    .pc_out(temp_pc_out)
  );
  
  
  // Immediate Generator
  imm_gen ig(
    .instr_in(instr_in_2),
    .imm_type_in(temp_imm_type_out),
    .imm_out(temp_imm_out)
  );
  
  
  // Immediate Adder
  imm_adder ia(
    .iadder_src(temp_iadder_src_out),
    .pc_in(temp_pc_out),
    .rs1_in(temp_rs1_out),
    .imm_in(temp_imm_out),
    .iadder_out(temp_iadder_out)
  );
  
  
  // Reg File
  reg_file rf(
    .clk_in(clk),
    .rst_in(rst),
    .rs1_addr_in(temp_rs1_addr_out),
    .rs2_addr_in(temp_rs2_addr_out),
    .rd_addr_in(temp_rd_adder_reg),
    .rd_data(temp_wb_mux_out),
    .wr_en_in(temp_wr_en_reg_out),
    .rs1_out(temp_rs1_out),
    .rs2_out(temp_rs2_out)
  );
  
  
  // Instruction Mux
  instruct_MUX multi(
    .flush_in(temp_flush_out),
    .instr_in(instr_in),
    .opcode_out(opcode),
    .func3_out(func3),
    .func7_out(func7),
    .rs1_addr_out(temp_rs1_addr_out),
    .rs2_addr_out(temp_rs2_addr_out),
    .rd_addr_out(temp_rd_addr_out),
    .instr_31_7_out(instr_in_2)
  );
  
  
  // Branch Unit
  branch_unit bu(
    .rs1_in(temp_rs1_out),
    .rs2_in(temp_rs2_out),
    .opcode_6_2_in(opcode[6:2]),
    .func3_in(func3),
    .branch_taken_out(branch_taken)
  );
  
  
  // Control Unit
  ctrl_unit cu(
    .clk_in(clk),
    .rst_in(rst),
    .flush_out(temp_flush_out),
    .pc_src_out(pc_src)
  );
  
  
  // Write Enable Generator
  wr_en_gen wg(
    .wr_en_reg_in(temp_wr_en_reg),
    .flush_in(temp_flush_out),
    .wr_en_reg_file_out(temp_wr_en_reg_out)
  );
  
  
  // Decoder Unit
  decoder du(
    .func7_5_in(func7[4]),
    .opcode_in(opcode),
    .func3_in(func3),
    .wb_mux_sel_out(temp_wb_mux_sel_out),
    .imm_type_out(temp_imm_type_out),
    .mem_wr_req_out(temp_mem_wr_req),
    .alu_opcode_out(temp_alu_opcode_out),
    .load_size_out(temp_load_size_out),
    .load_unsigned_out(temp_load_unsigned_out),
    .alu_src_out(temp_alu_src_out),
    .iadder_src_out(temp_iadder_src_out),
    .wr_en_out(temp_wr_en_out)
  );
  
  
  // Store Unit
  store_unit su(
    .mem_wr_req(temp_mem_wr_req),
    .func3(func3[1:0]),
    .iadder_in(temp_iadder_out),
    .rs2_in(temp_rs2_out),
    .dm_addr_out(dm_addr_out),
    .dm_wr_req_out(dm_wr_req_out),
    .dm_wr_mask_out(dm_wr_mask_out),
    .dm_data_out(dm_data_out)
  );
  
  
  // Reg Block 2
  reg_block_2 re2(
    .clk_in(clk),
    .rst_in(rst),
    .rd_adder_in(temp_rd_addr_out),
    .rs1_in(temp_rs1_out),
    .rs2_in(temp_rs2_out),
    .pc_plus_4_in(pc_plus_4),
    .branch_taken_in(branch_taken),
    .iadder_in(temp_iadder_out),
    .alu_opcode_in(temp_alu_opcode_out),
    .load_size_in(temp_load_size_out),
    .load_unsigned_in(temp_load_unsigned_out),
    .alu_src_in(temp_alu_src_out),
    .wb_mux_sel_in(temp_wb_mux_sel_out),
    .imm_in(temp_imm_out),
    .rf_wr_en(temp_wr_en_out),
    
    .iadder_out_reg_out(temp_iadder_out_reg),
    .rd_adder_reg_out(temp_rd_adder_reg),
    .rs1_reg_out(temp_rs1_reg),
    .rs2_reg_out(temp_rs2_reg),
    .pc_plus_4_reg_out(temp_pc_plus_4_reg),
    .alu_opcode_reg_out(temp_alu_opcode_reg),
    .load_size_reg_out(temp_load_size_reg),
    .load_unsigned_reg_out(temp_load_unsigned_reg),
    .alu_src_reg_out(temp_alu_src_reg),
    .wb_mux_sel_reg_out(temp_wb_mux_sel_reg_out),
    .imm_reg_out(temp_imm_reg),
    .rf_wr_en_reg(temp_wr_en_reg)
  );
  
  
  // Load Unit
  load_unit lu(
    .dm_data_in(dm_data_in),
    .iadder_out_1_to_0_in(temp_iadder_out_reg[1:0]),
    .load_unsigned_in(temp_load_unsigned_reg),
    .load_size_in(temp_load_size_reg),
    .load_output_out(temp_load_output)
  );
  
  
  // ALU Unit
  ALU au(
    .op_1_in(temp_rs1_reg),
    .op_2_in(alu_2nd_src),
    .opcode_in(temp_alu_opcode_reg),
    .result_out(temp_alu_result)
  );
  
  
  // Write Back Mux
  WB_MUX wu(
    .alu_src_reg_in(temp_alu_src_reg),
    .imm_reg_in(temp_imm_reg),
    .rs2_reg_in(temp_rs2_reg),
    .wb_mux_sel_reg_in(temp_wb_mux_sel_reg_out),
    .alu_result_in(temp_alu_result),
    .load_output_in(temp_load_output),
    .iadder_out_reg_in(temp_iadder_out_reg),
    .pc_plus_4_reg_in(temp_pc_plus_4_reg),
    .alu_2nd_src_mux_out(alu_2nd_src),
    .wb_mux_out(temp_wb_mux_out)
  );



endmodule

