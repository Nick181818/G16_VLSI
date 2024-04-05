
`include "ALU_block.v"
`include "branch_unit.v"
`include "control_unit.v"
`include "decoder_unit.v"
`include "imm_adder.v"
`include "imm_generator.v"
`include "instr_mux.v"
`include "load_unit.v"
`include "PC_unit.v"
`include "reg_block.v"
`include "reg_block2.v"
`include "reg_file.v"
`include "store_unit.v"
`include "wb_mux.v"
`include "wr_en_generator.v"

module top_module (
    input clk,
    input rst,
    input  [31:0] instr,
    output [31:0] iaddr, // For Instruction Memory

    input [31:0] dm_data_o,
    output [31:0] dm_data_in,
    output [31:0] dm_addr,
    output [3:0] dm_wr_mask,
  output [31:0]dm_wr_req
);

    wire [31:0] pc_mux;
    wire [31:0] pc_plus_4;
  //wire [30:0]iaddr_imm;

    // For reg block 1
    wire [31:0] pc_in_reg1;

    // From immediate generator
  wire  [31:0]imm_data;

    // For imm adder
   wire [31:0]iadder_data;

    // From Instruction Mux
    wire [2:0] fun_3;
  	wire [6:0] fun_7;
    wire [24:0] instr_31_7;
    wire [6:0] opcode;
    wire [4:0] rs1_addr;
    wire [4:0] rs2_addr;
    wire [4:0] rd_addr;


    // Form reg_mem
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;

    // From Reg 2 output
    wire [3:0] alu_opcode_reg2;
    wire alu_src_reg2;
    wire [31:0] iadder_out_reg2;
    wire  [31:0]imm_reg2;
    wire [1:0] load_size_reg2;
    wire load_unsigned_reg2;
    wire [31:0] pc_plus_4_reg2;
    wire [4:0] rd_addr_reg2;
    wire rf_wr_en_reg2;
    wire [31:0] rs1_reg2;
    wire [31:0] rs2_reg2;
    wire [2:0] wb_mux_sel_reg2;

    wire [31:0] result_alu;
    wire [31:0] lu_output;
    wire [31:0] alu_2nd_src_mux;
    wire [31:0] wb_mux_o;
    wire wr_en_reg_file; 
    wire branch_taken;
    wire flush;
    wire [1:0] pc_src;
    // From Decoder unit
    wire [2:0] wb_mux_sel;
    wire [2:0] imm_type;
    wire mem_wr_req;
    wire [3:0] ALU_opcode;
    wire [1:0] load_size;
    wire load_unsigned;
    wire ALU_src;
    wire iadder_src;
    wire rf_wr_en;

    //  PC_MUX
        PC_MUX PCM (
            .rst_in(rst),
            .pc_src_in(pc_src),
            .pc_in(pc_in_reg1),
            .branch_taken_in(branch_taken),
          .iaddr_in(iadder_data[30:0]),
            .pc_mux_o(pc_mux),
            .pc_plus_4_o(pc_plus_4),
            .iaddr_o(iaddr)
        );

    // Reg_Block 
        reg_block RB1(
            .pc_mux_in(pc_mux),
            .rst_in(rst),
            .clk_in(clk),
            .pc_o(pc_in_reg1)
        );

    //Imm_Generator 
        imm_generator IG (
            .instr_in(instr_31_7),
            .imm_type_in(imm_type),
            .imm_o(imm_data)
        );
        
    // Imm_Adder 
        imm_adder IA (
            .iadder_src(iadder_src),
            .pc_in(pc_in_reg1),
            .rs1_in(rs1_data),
            .imm_in(imm_data),
            .iadder_o(iadder_data)
        );

    // Reg_file 
        reg_file RF (
            .clk_in(clk),
            .rst_in(rst),
            .rs1_addr_in(rs1_addr),
            .rs2_addr_in(rs2_addr),
            .rd_addr_in(rd_addr_reg2),
            .rd_data(wb_mux_o),
            .wr_en_in(wr_en_reg_file),
            .rs1_o(rs1_data),
            .rs2_o(rs2_data)
        );

    //  Instr_mux 
        instr_mux IM (
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
        
    //Branch_unit 
        branch_unit BU (
            .rs1_in(rs1_data),
            .rs2_in(rs2_data),
            .opcode_6_2_in(opcode[6:2]),
            .fun_3_in(fun_3),
            .branch_taken_o(branch_taken)
        );

    // Control_unit 
        control_unit CU (
            .clk_in(clk),
            .rst_in(rst),
            .flush_o(flush),
            .pc_src_o(pc_src)
        );

    // wr_en_gen
        wr_en_generator WEG (
            .wr_en_reg_in(rf_wr_en_reg2),
            .flush_in(flush),
            .wr_en_reg_file_o(wr_en_reg_file)
        );

    // decoder
        decoder_unit Dec (
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
        
    // store_unit
        store_unit Store (
            .fun_3(fun_3),
            .iadder_in(iadder_data),
            .rs2_in(rs2_data),
            .mem_wr_req(mem_wr_req),
            .dm_data_o(dm_data_o),
            .dm_addr_o(dm_addr),
            .dm_wr_mask_o(dm_wr_mask),
            .dm_wr_req_o(dm_wr_req)
        ); 

    // reg_block2
        reg_block2 RB2 (
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

    // load_unit
        load_unit LU (
            .dm_data_in(dm_data_in),
            .iadder_out_1to0_in(iadder_out_reg2[1:0]),
            .load_unsigned_in(load_unsigned_reg2),
            .load_size_in(load_size_reg2),
            .load_output_o(lu_output)
        );

    // ALU_block
        ALU_block alu (
            .op_1_in(rs1_reg2),
            .op_2_in(alu_2nd_src_mux),
            .opcode_in(alu_opcode_reg2),
            .result_o(result_alu)
        );

    // wb_mux 
        wb_mux WB_MUX (
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
