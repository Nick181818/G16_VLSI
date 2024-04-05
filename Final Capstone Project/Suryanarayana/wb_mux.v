module wb_mux(
  
  input alu_src_reg_in,
  input [31:0] imm_reg_in,
  input [31:0] rs2_reg_in,
  input [2:0] wb_mux_sel_reg_in,
  input [31:0] alu_result_in,
  input [31:0] load_output_in,
  input [31:0] iadder_out_reg_in,
  input [31:0] pc_plus_4_reg_in,
  output [31:0] alu_2nd_src_mux_o,
  output reg [31:0] wb_mux_o

);
  
  assign alu_2nd_src_mux_o = (alu_src_reg_in)? rs2_reg_in : imm_reg_in;
  
  always@(*)
    begin 
      case(wb_mux_sel_reg_in)
        3'b000: wb_mux_o  = alu_result_in;
        3'b001: wb_mux_o  = load_output_in;
        3'b010: wb_mux_o  = imm_reg_in;
        3'b011: wb_mux_o  = iadder_out_reg_in;
        3'b101: wb_mux_o  = pc_plus_4_reg_in;
        default: wb_mux_o = alu_result_in;
      endcase 
    end 
endmodule