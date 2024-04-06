//
// Immediate Generator Block
//
module imm_gen (
    input [31:7] instr_in,      // Immediate Data from Instruction
    input [2:0] imm_type_in,    // Input for Deciding Type of Immediate Data 
    output reg [31:0] imm_out   // Sign Extended Immediate data
);

always @ (*)
begin
    case (imm_type_in)
        3'b000 : imm_out = 32'b0;  //R-Type
        3'b001 : imm_out = { {21{instr_in[31]}},instr_in[30:20]};  // I -Type
        3'b010 : imm_out = { {21{instr_in[31]}},instr_in[30:20]};  // S-Type
        3'b011 : imm_out = { {20{instr_in[31]}}, instr_in[7],instr_in[30:25], instr_in[11:8],1'b0 };  // B-Type
        3'b100 : imm_out = { instr_in[31:12],12'b0 };  // U-Type
        3'b101 : imm_out = { {12{instr_in[31]}},instr_in[19:12],instr_in[20],instr_in[30:21],1'b0 };  // J-Type
        3'b110 : imm_out = { {21{instr_in[31]}},instr_in[30:25],instr_in[11:7]};  // L-Type
        default: imm_out = { {21{instr_in[31]}},instr_in[30:20]};  // Default I-Type
    endcase
end
    
endmodule