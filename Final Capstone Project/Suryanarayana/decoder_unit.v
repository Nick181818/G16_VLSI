module decoder_unit (
    input fun_7_5_in,
    input [14:12] fun_3_in,
    input [6:0] opcode_in,
    output[2:0] wb_mux_sel_o,
    output[2:0] imm_type_o,
    output mem_wr_req_o,
    output[3:0] ALU_opcode_o,
    output[1:0] load_size_o,
    output load_unsigned_o,
    output ALU_src_o,
    output iadder_src_o,
    output wr_en_o
);
    // Wires for Opcode Decoder
    wire is_branch;
    wire is_jal;
    wire is_jalr;
    wire is_auipc;
    wire is_lui;
    wire is_op;
    wire is_op_imm;
    wire is_load;
    wire is_store;

    // Wires for Func3 Decoder
    wire is_addi;
    wire is_slti;
    wire is_sltiu;
    wire is_andi;
    wire is_ori;
    wire is_xori;

    // Assigning value to wires of Opcode generator
    assign is_branch =  opcode_in[6] & opcode_in[5] & !opcode_in[4] & !opcode_in[3] & !opcode_in[2];
    assign is_jal =     opcode_in[6] & opcode_in[5] & !opcode_in[4] & opcode_in[3] & opcode_in[2];
    assign is_jalr =    opcode_in[6] & opcode_in[5] & !opcode_in[4] & !opcode_in[3] & opcode_in[2];
    assign is_auipc =   !opcode_in[6] & !opcode_in[5] & opcode_in[4] & !opcode_in[3] & opcode_in[2];
    assign is_lui =    !opcode_in[6] & opcode_in[5] & opcode_in[4] & !opcode_in[3] & opcode_in[2];
    assign is_op =      !opcode_in[6] & opcode_in[5] & opcode_in[4] & !opcode_in[3] & !opcode_in[2];
    assign is_op_imm =  !opcode_in[6] & !opcode_in[5] & opcode_in[4] & !opcode_in[3] & !opcode_in[2];
    assign is_load =    !opcode_in[6] & !opcode_in[5] & !opcode_in[4] & !opcode_in[3] & !opcode_in[2];
    assign is_store =   !opcode_in[6] & opcode_in[5] & !opcode_in[4] & !opcode_in[3] & !opcode_in[2];


    // Assigning value to wires of Func3 Decoder
    assign is_addi = is_op_imm & !fun_3_in[14] & !fun_3_in[13] & !fun_3_in[12];
    assign is_slti = is_op_imm & !fun_3_in[14] & fun_3_in[13] & !fun_3_in[12];
    assign is_sltiu = is_op_imm & !fun_3_in[14] & fun_3_in[13] & fun_3_in[12];
    assign is_andi = is_op_imm & fun_3_in[14] & fun_3_in[13] & fun_3_in[12];
    assign is_ori = is_op_imm & fun_3_in[14] & fun_3_in[13] & !fun_3_in[12];
    assign is_xori = is_op_imm & fun_3_in[14] & !fun_3_in[13] & !fun_3_in[12];

    // Assigning  values to output ports
    assign ALU_opcode_o [2:0] = fun_3_in; 
    assign ALU_opcode_o [3] = fun_7_5_in & ~(is_addi | is_slti | is_sltiu | is_andi | is_ori | is_xori);

  assign load_size_o = fun_3_in [13:12];
  assign load_unsigned_o = fun_3_in [13:12];

    assign ALU_src_o = opcode_in [5]; 
        
    assign iadder_src_o = is_load | is_store | is_jalr;
    

    assign wr_en_o = is_lui | is_auipc | is_jalr | is_jal | is_op | is_load |  is_op_imm;
        
    assign wb_mux_sel_o [0] = is_load | is_auipc | is_jalr | is_jal | is_branch;        
    assign wb_mux_sel_o [1] = is_lui | is_auipc | is_branch | ~(is_jal | is_jalr);
    assign wb_mux_sel_o [2] = is_jal | is_jalr | ~ (is_load);
    
    assign imm_type_o [0] = is_op_imm | is_jalr | is_jal | is_branch;
    assign imm_type_o [1] = is_branch | is_store | is_load;
    assign imm_type_o [2] = is_lui | is_auipc | is_jal | is_load;

endmodule