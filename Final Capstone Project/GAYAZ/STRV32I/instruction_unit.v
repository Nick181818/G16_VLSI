module instruction_unit(
    input flush_in,
    input [31:0] inst_in,
    output [2:0] func3_out,
    output [6:0] func7_out,
    output [6:0] opcode_out,
    output [4:0] rs1_addr_out,
    output [4:0] rs2_addr_out,
    output [4:0] rd_addr_out,
    output [24:0] instr_31_to_7_out
    );
    
    wire [31:0]flush_out = 32'h0000_0013;
    
    assign func3_out            = (flush_in) ? flush_out[14:12] : inst_in[14:12];
    assign func7_out            = (flush_in) ? flush_out[31:25] : inst_in[31:25];
    assign opcode_out           = (flush_in) ? flush_out[6:0] : inst_in[6:0];
    assign rs1_addr_out         = (flush_in) ? flush_out[19:15] : inst_in[19:15];
    assign rs2_addr_out         = (flush_in) ? flush_out[24:20] : inst_in[24:20];
    assign rd_addr_out          = (flush_in) ? flush_out[11:7] : inst_in[11:7];
    assign instr_31_to_7_out    = (flush_in) ? flush_out[31:7] : inst_in[31:7];
   
endmodule
