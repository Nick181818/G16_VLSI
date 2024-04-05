module decoder_unit (
    input func_7_5_in,              // Function7 [5] value
    input [14:12] func3_in,         // Function3 value
    input [6:2] opcode_in,          // Opcode to Decide Type of Instruction
    output[2:0] wb_mux_sel_out,     // Write Back
    output[2:0] imm_type_out,       // Decides Type of Immediate Data
    output mem_wr_req_out,          // Request to write into Memory
    output[3:0] ALU_opcode_out,     // Decides Type of ALU Operation
    output[1:0] load_size_out,      // Decides the size of Loaded Data
    output load_unsigned_out,       // Decides the Loaded data is Unsigned or Signed
    output ALU_src_out,             // For ALU
    output iadder_src_out,          // For Immediate Adder
    output wr_en_out                // Write Enable for Register File
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
    assign is_branch    =   opcode_in[6]  & opcode_in[5]  & !opcode_in[4] & !opcode_in[3] & !opcode_in[2];  // Opcode value 11000
    assign is_jal       =   opcode_in[6]  & opcode_in[5]  & !opcode_in[4] & opcode_in[3]  & opcode_in[2];   // Opcode value 11011
    assign is_jalr      =   opcode_in[6]  & opcode_in[5]  & !opcode_in[4] & !opcode_in[3] & opcode_in[2];   // Opcode value 11001
    assign is_auipc     =   !opcode_in[6] & !opcode_in[5] & opcode_in[4]  & !opcode_in[3] & opcode_in[2];   // Opcode value 00101
    assign is_lui       =   !opcode_in[6] & opcode_in[5]  & opcode_in[4]  & !opcode_in[3] & opcode_in[2];   // Opcode value 01101
    assign is_op        =   !opcode_in[6] & opcode_in[5]  & opcode_in[4]  & !opcode_in[3] & !opcode_in[2];  // Opcode value 01100
    assign is_op_imm    =   !opcode_in[6] & !opcode_in[5] & opcode_in[4]  & !opcode_in[3] & !opcode_in[2];  // Opcode value 00100
    assign is_load      =   !opcode_in[6] & !opcode_in[5] & !opcode_in[4] & !opcode_in[3] & !opcode_in[2];  // Opcode value 00000
    assign is_store     =   !opcode_in[6] & opcode_in[5]  & !opcode_in[4] & !opcode_in[3] & !opcode_in[2];  // Opcode value 01000


    // Assigning value to wires of Func3 Decoder
    assign is_addi = is_op_imm & !func3_in[14] & !func3_in[13] & !func3_in[12]; // Func3 value 000
    assign is_slti = is_op_imm & !func3_in[14] & func3_in[13] & !func3_in[12];  // Func3 value 010
    assign is_sltiu = is_op_imm & !func3_in[14] & func3_in[13] & func3_in[12];  // Func3 value 011
    assign is_andi = is_op_imm & func3_in[14] & func3_in[13] & func3_in[12];    // Func3 value 111
    assign is_ori = is_op_imm & func3_in[14] & func3_in[13] & !func3_in[12];    // Func3 value 110
    assign is_xori = is_op_imm & func3_in[14] & !func3_in[13] & !func3_in[12];  // Func3 value 100

    // Assigning  values to output ports
    assign ALU_opcode_out [2:0] = func3_in; 
    assign ALU_opcode_out [3] = func_7_5_in & ~(is_addi | is_slti | is_sltiu | is_andi | is_ori | is_xori);

    assign load_size_out = func3_in [13:12];
    assign load_unsigned_out = func3_in [14];

    assign ALU_src_out = opcode_in [5]; 
        
    assign iadder_src_out = is_load | is_store | is_jalr;
    

    assign wr_en_out = is_lui | is_auipc | is_jalr | is_jal | is_op | is_load |  is_op_imm;
        
    assign wb_mux_sel_out [0] = is_load | is_auipc | is_jalr | is_jal | is_branch;        
    assign wb_mux_sel_out [1] = is_lui | is_auipc | is_branch | ~(is_jal | is_jalr);
    assign wb_mux_sel_out [2] = is_jal | is_jalr | ~ (is_load);
    
    assign imm_type_out [0] = is_op_imm | is_jalr | is_jal | is_branch;
    assign imm_type_out [1] = is_branch | is_store | is_load;
    assign imm_type_out [2] = is_lui | is_auipc | is_jal | is_load;
    
    assign mem_wr_req_out = is_store;

endmodule