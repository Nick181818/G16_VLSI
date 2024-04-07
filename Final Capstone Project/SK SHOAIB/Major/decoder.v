module decoder(
  
  input func7_5_in,
  input [6:0] opcode_in,
  input [2:0] func3_in,
  output [2:0] wb_mux_sel_out,
  output [2:0] imm_type_out,
  output mem_wr_req_out,
  output [3:0] alu_opcode_out,
  output [1:0] load_size_out,
  output load_unsigned_out,
  output alu_src_out,
  output iadder_src_out,
  output wr_en_out
  
);
  
  wire is_branch;
  wire is_jal;
  wire is_jalr;
  wire is_auipc;
  wire is_lui;
  wire is_op;
  wire is_op_imm;
  wire is_load;
  wire is_store;
  
  
  wire is_addi;
  wire is_slti;
  wire is_sltiu;
  wire is_andi;
  wire is_ori;
  wire is_xori;
  
  
  
  assign is_branch	=	(opcode_in[6:2] == 5'b11000)? 1'b1 : 1'b0;
  assign is_jal		  =	(opcode_in[6:2] == 5'b11011)? 1'b1 : 1'b0;
  assign is_jalr	  =	(opcode_in[6:2] == 5'b11001)? 1'b1 : 1'b0;
  assign is_auipc	  =	(opcode_in[6:2] == 5'b00101)? 1'b1 : 1'b0;
  assign is_lui		  =	(opcode_in[6:2] == 5'b01101)? 1'b1 : 1'b0;
  assign is_op		  =	(opcode_in[6:2] == 5'b01100)? 1'b1 : 1'b0;
  assign is_op_imm	=	(opcode_in[6:2] == 5'b00100)? 1'b1 : 1'b0;
  assign is_load  	=	(opcode_in[6:2] == 5'b00000)? 1'b1 : 1'b0;
  assign is_store 	=	(opcode_in[6:2] == 5'b01000)? 1'b1 : 1'b0;
 
  
  
  assign is_addi	=	(func3_in == 3'b000) & is_op_imm;
  assign is_slti	=	(func3_in == 3'b010) & is_op_imm;
  assign is_sltiu	=	(func3_in == 3'b001) & is_op_imm;
  assign is_andi	=	(func3_in == 3'b111) & is_op_imm;
  assign is_ori		=	(func3_in == 3'b110) & is_op_imm;
  assign is_xori	=	(func3_in == 3'b100) & is_op_imm;
        
  
  assign alu_opcode_out[2:0] = func3_in;
  assign alu_opcode_out[3]   = func7_5_in & ~(is_addi | is_slti | is_sltiu | is_andi | is_ori | is_xori);
  assign load_size_out       = func3_in[1:0];
  assign load_unsigned_out   = func3_in[2];
  assign alu_src_out         = opcode_in[4];
  
  assign iadder_src_out      = is_load | is_store | is_jalr;
  assign wr_en_out           = is_lui | is_auipc | is_jalr | is_jal | is_op |is_load | is_op_imm;
  
  assign wb_mux_sel_out[0]   = is_load | is_auipc | is_jalr | is_jal | is_branch;
  assign wb_mux_sel_out[1]   = is_lui | is_auipc | is_branch | ~(is_jal | is_jalr);
  assign wb_mux_sel_out[2]   = is_jal | is_jalr | ~(is_load);
  
  assign imm_type_out[0]     = is_op_imm | is_jal | is_jalr | is_branch;
  assign imm_type_out[1]     = is_branch | is_store |is_load;
  assign imm_type_out[2]     = is_lui | is_auipc | is_jal | is_load;
  
  assign mem_wr_req_out      = is_store;
  
endmodule
