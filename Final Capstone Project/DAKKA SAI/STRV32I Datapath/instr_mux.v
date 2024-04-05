module instr_mux(
  input flush_in,
  input [31:0]instr_in,
  output [6:0]opcode_o,
  output [2:0]fun_3_o,
  output [6:0]fun_7_o,
  output [4:0]rs1_addr_o,
  output [4:0]rs2_addr_o,
  output [4:0]rd_addr_o,
  output [24:0]instr_31_7_o
);    
    wire [31:0]flush_o = 32'h0000_0013;
    assign opcode_o       = (flush_in) ? flush_o[6:0] : instr_in[6:0];
    assign fun_3_o        = (flush_in) ? flush_o[14:12] : instr_in[14:12];
    assign fun_7_o        = (flush_in) ? flush_o[31:25] : instr_in[31:25];
    assign rs1_addr_o     = (flush_in) ? flush_o[19:15] : instr_in[19:15];
    assign rs2_addr_o     = (flush_in) ? flush_o[24:20] : instr_in[24:20];
    assign rd_addr_o      = (flush_in) ? flush_o[11:7] : instr_in[11:7];
    assign instr_31_7_o   = (flush_in) ? flush_o[31:7] : instr_in[31:7];  
endmodule

  