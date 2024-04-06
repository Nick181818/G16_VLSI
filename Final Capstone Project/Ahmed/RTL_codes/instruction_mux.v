module instruction_mux (
    input flush_in,                 // Used for Reset 
    input [31:0] instr_in,          // 32-Bit Intruction
    output [6:0] opcode_out,        // Extracted Opcode
    output [2:0] func3_out,         // Extracted Func3
    output [6:0] func7_out,         // Extracted Func7
    output [4:0] rs1_addr_out,      // Extracted Address of Source Register 1
    output [4:0] rs2_addr_out,      // Extracted Address of Source Register 2
    output [4:0] rd_addr_out,       // Extracted Address of Destination Register
    output [24:0] instr_31_7_out    // Extracted For Immediate Values
);
 
wire [31:0] temp_instr;

assign temp_instr = flush_in ? 32'h00000013 : instr_in;

assign opcode_out = temp_instr[6:0];
assign func3_out = temp_instr[14:12];
assign func7_out = temp_instr[31:25];
assign rs1_addr_out = temp_instr[19:15];
assign rs2_addr_out = temp_instr[24:20];
assign rd_addr_out = temp_instr[11:7];
assign instr_31_7_out = temp_instr[31:7];


    
endmodule