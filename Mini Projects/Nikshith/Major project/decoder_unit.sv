module decoder_unit (
    input logic  fun_7_5_in,
    input logic [14:12] fun_3_in,
  input logic [6:0] opcode_in,
    output logic [2:0] wb_mux_sel_o,
    output logic [2:0] imm_type_o,
    output logic mem_wr_req_o,
    output logic [3:0] ALU_opcode_o,
    output logic [1:0] load_size_o,
    output logic load_unsigned_o,
    output logic ALU_src_o,
    output logic iadder_src_o,
    output logic wr_en_o
);

    logic is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store;
    logic is_addi, is_slti, is_sltiu, is_andi, is_ori, is_xori;

    // Opcode Decoding
    assign is_branch   = opcode_in[6] && opcode_in[5] && !opcode_in[4] && !opcode_in[3] && !opcode_in[2];
    assign is_jal      = opcode_in[6] && opcode_in[5] && !opcode_in[4] && opcode_in[3] && opcode_in[2];
    assign is_jalr     = opcode_in[6] && opcode_in[5] && !opcode_in[4] && !opcode_in[3] && opcode_in[2];
    assign is_auipc    = !opcode_in[6] && !opcode_in[5] && opcode_in[4] && !opcode_in[3] && opcode_in[2];
    assign is_lui      = !opcode_in[6] && opcode_in[5] && opcode_in[4] && !opcode_in[3] && opcode_in[2];
    assign is_op       = !opcode_in[6] && opcode_in[5] && opcode_in[4] && !opcode_in[3] && !opcode_in[2];
    assign is_op_imm   = !opcode_in[6] && !opcode_in[5] && opcode_in[4] && !opcode_in[3] && !opcode_in[2];
    assign is_load     = !opcode_in[6] && !opcode_in[5] && !opcode_in[4] && !opcode_in[3] && !opcode_in[2];
    assign is_store    = !opcode_in[6] && opcode_in[5] && !opcode_in[4] && !opcode_in[3] && !opcode_in[2];

    // Func3 Decoding
    assign is_addi   = is_op_imm && !fun_3_in[2] && !fun_3_in[1] && !fun_3_in[0];
    assign is_slti   = is_op_imm && !fun_3_in[2] && fun_3_in[1] && !fun_3_in[0];
    assign is_sltiu  = is_op_imm && !fun_3_in[2] && fun_3_in[1] && fun_3_in[0];
    assign is_andi   = is_op_imm && fun_3_in[2] && fun_3_in[1] && fun_3_in[0];
    assign is_ori    = is_op_imm && fun_3_in[2] && fun_3_in[1] && !fun_3_in[0];
    assign is_xori   = is_op_imm && fun_3_in[2] && !fun_3_in[1] && !fun_3_in[0];

    // Assigning values to output ports
    always @* begin
        ALU_opcode_o = {fun_3_in, 2'b00}; // Concatenating fun_3_in with 2'b00
        ALU_opcode_o[3] = fun_7_5_in & ~(is_addi | is_slti | is_sltiu | is_andi | is_ori | is_xori);
    end

    assign load_size_o = fun_3_in[0];
    assign load_unsigned_o = fun_3_in[2];
    assign ALU_src_o = opcode_in[5]; 
    assign iadder_src_o = is_load | is_store | is_jalr;
    assign wr_en_o = is_lui | is_auipc | is_jalr | is_jal | is_op | is_load | is_op_imm;

    // Control Signals for Write-back MUX selection
    assign wb_mux_sel_o[0] = is_load | is_auipc | is_jalr | is_jal | is_branch;        
    assign wb_mux_sel_o[1] = is_lui | is_auipc | is_branch | ~(is_jal | is_jalr);
    assign wb_mux_sel_o[2] = is_jal | is_jalr | ~(is_load);
    
    // Control Signals for Immediate type selection
    assign imm_type_o[0] = is_op_imm | is_jalr | is_jal | is_branch;
    assign imm_type_o[1] = is_branch | is_store | is_load;
    assign imm_type_o[2] = is_lui | is_auipc | is_jal | is_load;

endmodule
