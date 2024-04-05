module STRV32I (
    input clk,
    input rst,
    input  [31:0] instr, // Instruction
    output [31:0] iaddr, // Address For Instruction Memory

    input [31:0] dm_data_out,   // Data to be Stored
    output [31:0] dm_data_in,   // Data to be Loaded
    output [31:0] dm_addr,      // Address location for Read or Write 
    output [31:0] dm_wr_mask,   // Mask for loadind Data
    output dm_wr_req            // Request for Writing into Data Memory
);
//-------------------------------------------------------------------------
    // Assigning Wires required in Connecting Modules

    // From PC MUX
    wire [31:0] pc_mux;
    wire [31:0] pc_plus_4;
    wire iaddr_imm;

    // For reg block 1
    wire [31:0] pc_in_reg1;

    // From immediate generator
    wire [31:0] imm_data;

    // For imm adder
    wire iadder_data;

    // From Instruction Mux
    wire [2:0] func3;
    wire [6:0] func7;
    wire [24:0] instr_31_7;
    wire [6:0] opcode;
    wire [4:0] rs1_addr;
    wire [4:0] rs2_addr;
    wire [4:0] rd_addr;


    // Form Register memory
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;

    // From Reg 2 output
    wire [2:0] alu_opcode_reg2;
    wire alu_src_reg2;
    wire [31:0] iadder_out_reg2;
    wire [31:0] imm_reg2;
    wire [1:0] load_size_reg2;
    wire load_unsigned_reg2;
    wire [31:0] pc_plus_4_reg2;
    wire [4:0] rd_addr_reg2;
    wire rf_wr_en_reg2;
    wire [31:0] rs1_reg2;
    wire [31:0] rs2_reg2;
    wire [2:0] wb_mux_sel_reg2;

    // From ALU
    wire [31:0] result_alu;

    // from Load Unit
    wire [31:0] lu_output;

    //From WB Mux
    wire [31:0] alu_2nd_src_mux;
    wire [31:0] wb_mux_out; // To be store in destination register

    // From write enabler
    wire wr_en_reg_file; // Write enable for register memory

    // From Branch Unit
    wire branch_taken;

    // From Control Unit 
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



//-------------------------------------------------------------------------
    // Instantiating modules
    //----------------------

    // Instantiating PC_mux -----------
        PC_mux PC_unit (
            .rst_in(rst),
            .pc_src_in(pc_src),
            .pc_in(pc_in_reg1),
            .branch_taken_in(branch_taken),
            .iaddr_in(iaddr_imm),
            .pc_mux_out(pc_mux),
            .pc_plus_4_out(pc_plus_4),
            .iaddr_out(iaddr)
        );

    // Instantiating Reg Block ! -----------
        reg_block_1 Reg_Block (
            .pc_mux_in(pc_mux),
            .rst_in(rst),
            .clk_in(clk),
            .pc_out(pc_in_reg1)
        );

    // Instantiating Immediate Generator -----------
        imm_gen Imm_generator (
            .instr_in(instr_31_7),
            .imm_type_in(imm_type),
            .imm_out(imm_data)
        );
        
    // Instantiating Immediate Adder -----------
        imm_adder Adder (
            .iadder_src(iadder_src),
            .pc_in(pc_in_reg1),
            .rs1_in(rs1_data),
            .imm_in(imm_data),
            .iadder_out(iadder_data)
        );

    // Instantiating Register_file -----------
        reg_file Registers (
            .clk_in(clk),
            .rst_in(rst),
            .rs1_addr_in(rs1_addr),
            .rs2_addr_in(rs2_addr),
            .rd_addr_in(rd_addr_reg2),
            .rd_data(wb_mux_out),
            .wr_en_in(wr_en_reg_file),
            .rs1_out(rs1_data),
            .rs2_out(rs2_data)
        );

    // Instantiating Instruction MUX -----------
        instruction_mux Multiplexer (
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
        
    // Instantiating Branch Unit -----------
        branch_unit Branch_Unit (
            .rs1_in(rs1_data),
            .rs2_in(rs2_data),
            .opcode_6_2_in(opcode[6:2]),
            .func3_in(func3),
            .branch_taken_out(branch_taken)
        );

    // Instantiating Control Unit -----------
        ctrl_unit CU (
            .clk_in(clk),
            .rst_in(rst),
            .flush_out(flush),
            .pc_src_out(pc_src)
        );

    // Instantiating Write Enable Generator -----------
        wr_en_gen Write_Enabler (
            .wr_en_reg_in(rf_wr_en_reg2),
            .flush_in(flush),
            .wr_en_reg_file_out(wr_en_reg_file)
        );

    // Instantiating Decoder -----------
        decoder_unit Decoder (
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
        
    // Instantiating Store Unit -----------
        store_unit Store (
            .func3(func3),
            .iadder_in(iadder_data),
            .rs2_in(rs2_data),
            .mem_wr_req(mem_wr_req),
            .dm_data_out(dm_data_out),
            .dm_addr_out(dm_addr),
            .dm_wr_mask_out(dm_wr_mask),
            .dm_wr_req_out(dm_wr_req)
        ); 

    // Instantiating Reg Block 2 -----------
        reg_block_2 Reg_Block_2 (
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
            
            .rd_addr_reg_out(rd_addr_reg2),
            .rs1_reg_out(rs1_reg2),
            .rs2_reg_out(rs2_reg2),
            .pc_plus_4_reg_out(pc_plus_4_reg2),
            .iaddr_reg_out(iadder_out_reg2),
            .alu_opcode_reg_out(alu_opcode_reg2),
            .load_size_reg_out(load_size_reg2),
            .load_unsigned_reg_out(load_unsigned_reg2),
            .ALU_src_reg_out(alu_src_reg2),
            .rf_wr_reg_out(rf_wr_en_reg2),
            .wb_mux_sel_reg_out(wb_mux_sel_reg2),
            .imm_reg_out(imm_reg2)
        );

    // Instantiating Load Unit -----------
        load_unit Load_unit (
            .dm_data_in(dm_data_in),
            .iadder_out_1to0_in(iadder_out_reg2[1:0]),
            .load_unsigned_in(load_unsigned_reg2),
            .load_size_in(load_size_reg2),
            .lu_output_out(lu_output)
        );

    // Instantiating Arithematic Logic Unit -----------
        ALU ALU (
            .op_1_in(rs1_reg2),
            .op_2_in(alu_2nd_src_mux),
            .opcode_in(alu_opcode_reg2),
            .result_out(result_alu)
        );

    // Instantiating WB MUX -----------
        wb_mux WB_MUX (
            .ALU_src_reg_in(alu_src_reg2),
            .imm_reg_in(imm_reg2),
            .rs2_reg_in(rs2_reg2),
            .wb_mux_sel_reg_in(wb_mux_sel_reg2),
            .ALU_result_in(result_alu),
            .lu_output_in(lu_output),
            .iadder_out_reg_in(iadder_out_reg2),
            .pc_plus_4_reg_in(pc_plus_4_reg2),
            .alu_2nd_src_mux_out(alu_2nd_src_mux),
            .wb_mux_out(wb_mux_out)
        );     

endmodule