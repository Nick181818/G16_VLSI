`include "alu_unit.v"
`include "branch_unit.v"
`include "control_unit.v"
`include "decoder_unit.v"
`include "immediate_adder.v"
`include "immediate_generator.v"
`include "instruction_unit.v"
`include "load_unit.v"
`include "pc_unit.v"
`include "reg_block_1.v"
`include "reg_block_2.v"
`include "reg_file.v"
`include "store_unit.v"
`include "wb_mux_unit.v"
`include "wr_en_gen.v"

module RISC_TOP(
    input clk_in,
    input rst_in,
    input [31:0] dmdata_in,
  	input [31:0] inst_in,
    output dmwr_req_out,
    output [3:0] dmwr_mask_out,
    output [31:0] imaddr_out,
    output [31:0] dmaddr_out,
    output [31:0] dmdata_out
    );
    
    
    
    // Signals for Immediate Adder
    wire        iadder_src;
    wire [31:0] rs1;
    wire [31:0] iadder_out;
   
    // Signals for Immediate Generator
    wire [24:0] instr_imm_in;
    wire [2:0]  imm_type;
    wire [31:0] imm_data_out;
   
    // Signals for PC Mux
    wire [1:0]  pc_src;
    wire        branch_taken;
    wire        misaligned_instr;
    // wire [30:0] iadder_in
    wire [31:0] pc_mux;
    wire [31:0] pc_plus_4;
    // wire        i_addr;
    
    // Signals for Reg File
    wire [4:0]  rs1_adder;
    wire [4:0]  rs2_adder;
    wire [4:0]  rd_adder;
    wire        wr_enb_int_file;
    wire [31:0] wb_mux_out;
    wire [31:0] rs2;
    
    // Signals for wr_en_generator
    wire        flush_in;
    wire        wr_enb_reg;
    
    // Signals for Instruction MUX
    wire [6:0]  OpCode;
    wire [6:0]  funct7;
    wire [2:0]  funct3;
    
    // Signals for Decoder
    wire [2:0]  wb_mux_sel;
    wire [3:0]  alu_opcode;
    wire [1:0]  load_size;
    wire        load_unsigned;
    wire        alu_src;
    wire        rf_wr_en;
    wire        mem_wr_req;
   
    // Signal for reg1
    wire [31:0] pc_out_stage1;
    
    // Signals for Reg block 2
    wire        load_unsigned_reg;
  	wire        alu_src_reg;
    wire        rf_wr_en_reg;
    wire [3:0]  alu_opcode_reg;
    wire [1:0]  load_size_reg;
    wire [2:0]  wb_mux_sel_reg;
    wire [31:0] pc_reg_2;
    wire [4:0]  rd_addr_reg;
    wire [31:0] imm_reg_in;
    wire [31:0] iadder_out_reg;
    wire [31:0] pc_plus_4_reg;
    wire [31:0] rs2_reg;
    wire [31:0] rs1_reg;
   
    // Signals for Load Unit
    wire [31:0] lu_output;
    wire [31:0] alu_2nd_src;

    
    // Signals for ALU
    wire [31:0] ALU_result;
    
    // Design Instantiation
    
    // PC Mux
    pc_unit pc_uut(
        .rst_in(rst_in),
        .pc_src_in(pc_src),
        .misaligned_instr_out(misaligned_instr),
        .pc_mux_out(pc_mux),
        .pc_in(pc_out_stage1),
        .branch_taken_in(branch_taken),
        .iaddr_in(iadder_out[31:1]),
        .pc_plus_4_out(pc_plus_4),
        .i_addr_out(imaddr_out)
    );
    
    
    // immediate_generator
    immediate_generator immediate_generator_uut(
        .inst_in(instr_imm_in),
        .imm_type_in(imm_type),
        .imm_out(imm_data_out)
    );
   
    // immediate_adder
    immediate_adder immediate_adder_uut (
        .pc_in(pc_out_stage1),
        .rs1_in(rs1),
        .imm_in(imm_data_out),
        .iaddr_src_in(iadder_src),
        .iaddr_out(iadder_out)
    );
    
    // branch_unit
    branch_unit branch_unit_uut (
        .rs1_in(rs1),
        .rs2_in(rs2),
        .opcode_6_to_2_in(OpCode[6:2]),
        .func3_in(funct3),
        .branch_taken_out(branch_taken)
    );
    
    // reg_file
    reg_file reg_file_uut (
        .clk_in(clk_in),
        .rst_in(rst_in),
        .rs1_addr_in(rs1_adder),
        .rs2_addr_in(rs2_adder),
        .rd_addr_in(rd_addr_reg),
        .rd_data(wb_mux_out),
        .wr_en_in(wr_enb_int_file),
        .rs1_out(rs1),
        .rs2_out(rs2)
    );
    
    // Write_enb_generator
    wr_en_gen wr_en_gen_uut (
        .flush_in(flush_in),
        .wr_en_reg_in(rf_wr_en_reg),
        .wr_en_reg_out(wr_enb_int_file)
    );
    
    // ALU
    alu_unit alu_unit_uut (
        .op_1_in(rs1_reg),
        .op_2_in(alu_2nd_src),
        .opcode_in(alu_opcode_reg),
        .alu_result(ALU_result)
    );
  
    // instruction_mux
    instruction_unit instruction_unit_uut(
        .flush_in(flush_in),
        .inst_in(inst_in),
        .opcode_out(OpCode),
        .func3_out(funct3),
        .func7_out(funct7),
        .rs1_addr_out(rs1_adder),
        .rs2_addr_out(rs2_adder),
        .rd_addr_out(rd_adder),
        .instr_31_to_7_out(instr_imm_in)
    );
    
    // decoder_unit
    decoder_unit decoder_unit_uut(
        .func_3_in(funct3),
        .func_7_to_5_in(funct7[5]),
        .opcode_in(OpCode),
        .wb_mux_sel_out(wb_mux_sel),
        .imm_type_out(imm_type),
        .load_size_out(load_size),
        .load_unsigned_out(load_unsigned),
        .mem_wr_req_out(mem_wr_req),
        .ALU_opcode_out(alu_opcode),
        .ALU_src_out(alu_src),
        .iadder_src_out(iadder_src),
        .wr_en_out(rf_wr_en)
        );
    
    // Control_unit
    control_unit control_unit(
        .clk_in(clk_in),
        .rst_in(rst_in),
        .flush_out(flush_in),
        .pc_src_out(pc_src)
           );
  
  
    // Reg_block_1
    reg_block_1 reg_block_1_uut (
        .clk(clk_in),
        .rst_in(rst_in),
        .pc_mux_in(pc_mux),
        .pc_out(pc_out_stage1)
    );
  
  
    // reg_block_2
    reg_block_2 reg_block_2_uut (
        .clk_in(clk_in),
        .rst_in(rst_in),
        .rd_addr_in(rd_adder),
        .rs1_in(rs1),
        .rs2_in(rs2),
        .pc_in(pc_mux),
        .pc_plus_4_in(pc_plus_4),
        .wb_mux_sel_in(wb_mux_sel),
        .imm_in(imm_data_out),
        .rd_addr_reg_out(rd_addr_reg),
        .rs1_reg_out(rs1_reg),
        .branch_taken_in(branch_taken),
        .iadder_in(iadder_out),
        .alu_opcode_in(alu_opcode),
        .alu_opcode_reg_out(alu_opcode_reg),
        .alu_src_in(alu_src),
        .rf_wr_en_in(rf_wr_en),
        .load_unsigned_reg_out(load_unsigned_reg),
        .load_size_in(load_size),
        .load_unsigned_in(load_unsigned),
        .pc_plus_4_reg_out(pc_plus_4_reg),
        .iadder_out_reg_out(iadder_out_reg),
        .alu_src_reg_out(alu_src_reg),
        .rs2_reg_out(rs2_reg),
        .pc_reg_out(pc_reg_2),
        .load_size_reg_out(load_size_reg),
        .rf_wr_en_reg_out(rf_wr_en_reg),
        .wb_mux_sel_reg_out(wb_mux_sel_reg),
        .imm_reg_out(imm_reg_in)
    );
    
    
    // load_unit
    load_unit load_unit_uut (
        .dmdata_in(dmdata_in),
        .iadder_out_1_to_0_in(iadder_out_reg[1:0]),
        .load_unsigned_in(load_unsigned_reg),
        .load_size_in(load_size_reg),
        .lu_output_out(lu_output)
    );
  
  
    // store_unit
    store_unit store_unit_uut (
        .func3_in(funct3[1:0]),
        .mem_wr_req_in(mem_wr_req),
        .dmdata_out(dmdata_out),
        .iadder_in(iadder_out),
        .rs2_in(rs2),
        .dmaddr_out(dmaddr_out),
        .dmwr_mask_out(dmwr_mask_out),
        .dmwr_req_out(dmwr_req_out)
    ); 
  
    
    // wb_mux_unit
    wb_mux_unit wb_mux_unit_uut (
        .alu_src_reg_in(alu_src_reg),
        .wb_mux_sel_reg_in(wb_mux_sel_reg),
        .iadder_out_reg(iadder_out_reg),
        .pc_plus_4_reg_in(pc_plus_4_reg),
        .alu_result_in(ALU_result),
        .lu_output_in(lu_output),
        .imm_reg_in(imm_reg_in),
        .rs2_reg_in(rs2_reg),
        .wb_mux_out(wb_mux_out),
        .alu_2nd_src_mux_out(alu_2nd_src)
    );
    
endmodule
