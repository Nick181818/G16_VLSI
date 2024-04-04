module immediate_generator(
  
  input [31:0] instr_in,
  input [2:0] imm_type_in,
  output reg  imm_out

);
  
 
  
 /* assign r_type = 32'h0000_0000;
  assign i_type = {{20{instr_in[31]}},instr_in[31:25],instr_in[24:20]};
  assign l_type = {{20{instr_in[31]}},instr_in[31:20]};
  assign s_type = {{20{instr_in[31]}},instr_in[31:25],instr_in[11:7]};
  assign b_type = {{19{instr_in[31]}},instr_in[31],instr_in[30:25],instr_in[11:8],instr_in[7],1'b0};
  assign j_type = {{11{instr_in[31]}},instr_in[31],instr_in[19:12],instr_in[20],instr_in[30:21],1'b0};
  assign u_type = {instr_in[31:12],12'b0}; */
  
  
  
  
  always@(*)
    begin 
      case(imm_type_in)
        3'b000: imm_out = 32'b0;
        3'b001: imm_out = {{20{instr_in[31]}},instr_in[31:25],instr_in[24:20]};
        3'b010: imm_out = {{20{instr_in[31]}},instr_in[31:25],instr_in[11:7]};
        3'b011: imm_out = {{19{instr_in[31]}},instr_in[31],instr_in[30:25],instr_in[11:8],instr_in[7],1'b0};
        3'b100: imm_out = {instr_in[31:12],12'b0};
        3'b101: imm_out = {{11{instr_in[31]}},instr_in[31],instr_in[19:12],instr_in[20],instr_in[30:21],1'b0};
        3'b110: imm_out = {{20{instr_in[31]}},instr_in[31:20]};
        3'b111: imm_out = {{20{instr_in[31]}},instr_in[31:25],instr_in[24:20]};
        default: imm_out = {{20{instr_in[31]}},instr_in[31:25],instr_in[24:20]};
      endcase 
    end 
  
endmodule