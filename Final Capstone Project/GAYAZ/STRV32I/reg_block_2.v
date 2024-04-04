module reg_block_2(
  
  input clk_in,
  input rst_in,
  input [4:0] rd_adder_in,
  input [31:0] rs1_in,
  input [31:0] rs2_in,
  input [31:0] pc_in,
  input [31:0] pc_plus_4_in,
  input branch_taken_in,
  input [31:0] iadder_in,
  input [3:0] alu_opcode_in,
  input [1:0] load_size_in,
  input load_unsigned_in,
  input alu_src_in,
  input [2:0] wb_mux_sel_in,
  input imm_in,
  input rf_wr_en,
  output wire [31:0] iadder_out_reg_out,
  output reg [4:0] rd_adder_reg_out,
  output reg [31:0] rs1_reg_out,
  output reg [31:0] rs2_reg_out,
  output reg [31:0] pc_reg_out,
  output reg [31:0] pc_plus_4_reg_out,
  output reg [3:0] alu_opcode_reg_out,
  output reg [1:0] load_size_reg_out,
  output reg load_unsigned_reg_out,
  output reg alu_src_reg_out,
  output reg [2:0] wb_mux_sel_reg_out,
  output reg imm_reg_out,
  output reg rf_wr_en_reg_out

);
  
  assign iadder_out_reg_out = (branch_taken_in)? {iadder_in[31:1],1'b0} : iadder_in;
  
  always@(posedge clk_in)
    begin 
      if(!rst_in) 
        begin 
          rd_adder_reg_out      <= rd_adder_in;
          rs1_reg_out           <= rs1_in;
          rs2_reg_out           <= rs2_in;
          pc_reg_out            <= pc_in;
          pc_plus_4_reg_out     <= pc_plus_4_in;
          alu_opcode_reg_out    <= alu_opcode_in;
          load_size_reg_out     <= load_size_in;
          load_unsigned_reg_out <= load_unsigned_in;
          alu_src_reg_out       <= alu_src_in;
          wb_mux_sel_reg_out    <= wb_mux_sel_in;
          imm_reg_out           <= imm_in;
          rf_wr_en_reg_out      <= rf_wr_en; 
        end 
      else 
        begin 
          rd_adder_reg_out      <= 5'b0;
          rs1_reg_out           <= 32'b0;
          rs2_reg_out           <= 32'b0;
          pc_reg_out            <= 32'b0;
          pc_plus_4_reg_out     <= 32'b0;
          alu_opcode_reg_out    <= 4'b0;
          load_size_reg_out     <= 2'b00;
          load_unsigned_reg_out <= 1'b0;
          alu_src_reg_out       <= 1'b0;
          wb_mux_sel_reg_out    <= 3'b000;
          imm_reg_out           <= 1'b0;
          rf_wr_en_reg_out      <= 1'b0; 
        end 
    end 
  
endmodule