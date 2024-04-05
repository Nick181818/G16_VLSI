module decoder(
    input funct7_5_in,
    input [6:2] opcode_in,
    input [2:0] funct3_in,
    output [2:0] wb_mux_sel_out,
    output [2:0] imm_type_out,
    output mem_wr_req_out,
    output [3:0] alu_opcode_out,
    output [1:0] load_size_out,
    output load_unsigned_out,
    output alu_src_out,
    output iadder_src_out,
    output rf_wr_en_out
);

// Opcode Decoder
wire is_branch = (opcode_in == 5'b11000);
wire is_jal = (opcode_in == 5'b11011);
wire is_jalr = (opcode_in == 5'b11001);
wire is_auipc = (opcode_in == 5'b00101);
wire is_lui = (opcode_in == 5'b01101);
wire is_op = (opcode_in == 5'b01100);
wire is_op_imm = (opcode_in == 5'b00100);
wire is_load = (opcode_in == 5'b00000);
wire is_store = (opcode_in == 5'b01000);

// Funct3 Decoder
wire [5:0] funct3_decoded_net;
assign funct3_decoded_net = (6'b1 << funct3_in);

// Immediate Operations
wire is_addi = funct3_decoded_net[0] & is_op_imm;
wire is_slti = funct3_decoded_net[2] & is_op_imm;
wire is_sltiu = funct3_decoded_net[3] & is_op_imm;
wire is_andi = funct3_decoded_net[5] & is_op_imm;
wire is_ori = funct3_decoded_net[4] & is_op_imm;
wire is_xori = funct3_decoded_net[1] & is_op_imm;

// Assigning Outputs
assign alu_opcode_out = {(funct7_5_in & ~(is_addi | is_slti | is_sltiu | is_andi | is_ori | is_xori)), funct3_in};
assign load_size_out = funct3_in[1:0];
assign load_unsigned_out = funct3_in[2];
assign alu_src_out = opcode_in[5];
assign iadder_src_out = is_load | is_store | is_jalr;
assign rf_wr_en_out = is_lui | is_auipc | is_jalr | is_jal | is_op | is_load | is_op_imm;
assign wb_mux_sel_out[0] = is_load | is_auipc | is_jalr | is_jal | is_branch;
assign wb_mux_sel_out[1] = is_lui | is_auipc | is_branch | ~(is_jal | is_jalr);
assign wb_mux_sel_out[2] = is_jal | is_jalr | ~(is_load);
assign imm_type_out[0] = is_op_imm | is_load | is_jal | is_jalr | is_branch;
assign imm_type_out[1] = is_branch | is_store;
assign imm_type_out[2] = is_lui | is_auipc | is_jal;
assign mem_wr_req_out = is_store;

endmodule