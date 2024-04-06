module imm_gen(
  
  input [31:7] instr_in,
  input [2:0] imm_type_in,
  output reg [31:0] imm_out

);
  
 
  always@(*)
    begin 
      case(imm_type_in)
        3'b000: imm_out  = 32'b0;                                                                               // R-Type (000)
        3'b001: imm_out  = {{20{instr_in[31]}},instr_in[31:25],instr_in[24:20]};                                // I-Type (001)
        3'b010: imm_out  = {{20{instr_in[31]}},instr_in[31:25],instr_in[11:7]};                                 // S-Type (010)
        3'b011: imm_out  = {{19{instr_in[31]}},instr_in[31],instr_in[30:25],instr_in[11:8],instr_in[7],1'b0};   // B-Type (011)
        3'b100: imm_out  = {instr_in[31:12],12'b0};                                                             // U-Type (100)
        3'b101: imm_out  = {{11{instr_in[31]}},instr_in[31],instr_in[19:12],instr_in[20],instr_in[30:21],1'b0}; // J-Type (101)
        3'b110: imm_out  = {{20{instr_in[31]}},instr_in[31:20]};                                                // L-Type (110)
        3'b111: imm_out  = {{20{instr_in[31]}},instr_in[31:25],instr_in[24:20]};                                // I-Type (111)
        default: imm_out = {{20{instr_in[31]}},instr_in[31:25],instr_in[24:20]};                                // I-Type (Default)
      endcase 
    end 
  
endmodule
        
