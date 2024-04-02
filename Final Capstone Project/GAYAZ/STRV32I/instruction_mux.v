module instruction_mux(
  
  input flush_in,
  input  [31:0] instr_in,
  output reg [6:0] opcode_out,
  output reg [2:0] func3_out,
  output reg [6:0] func7_out,
  output reg [4:0] rs1_addr_out,
  output reg [4:0] rs2_addr_out,
  output reg [4:0] rd_addr_out,
  output reg [24:0] instr_31_7_out


);
  
  wire [31:0] flush_instr_in;
  
  assign flush_instr_in = 32'h0000_0013;
  
  always@(*)
    begin 
      if(!flush_in)
        begin 
          opcode_out     = instr_in[6:0];
          rd_addr_out    = instr_in[11:7];
          func3_out      = instr_in[14:12];
          rs1_addr_out   = instr_in[19:15];
          rs2_addr_out   = instr_in[24:20];
          instr_31_7_out = instr_in[31:7];
        end 
      else
        begin
          opcode_out     = flush_instr_in[6:0];
          rd_addr_out    = flush_instr_in[11:7];
          func3_out      = flush_instr_in[14:12];
          rs1_addr_out   = flush_instr_in[19:15];
          rs2_addr_out   = flush_instr_in[24:20];
          instr_31_7_out = flush_instr_in[31:7];
        end 
    end 
  
endmodule