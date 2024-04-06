module wb_mux_unit(
    input alu_src_reg_in,
    input [2:0] wb_mux_sel_reg_in,
    input [31:0] iadder_out_reg,
    input [31:0] pc_plus_4_reg_in,
    input [31:0] alu_result_in,
    input [31:0] lu_output_in,
    input [31:0] imm_reg_in,
    input [31:0] rs2_reg_in,
    output [31:0] wb_mux_out,
    output [31:0] alu_2nd_src_mux_out
    );
    
    assign alu_2nd_src_mux_out = (alu_src_reg_in) ? rs2_reg_in : imm_reg_in;
    
  parameter [2:0] mux1         = 3'b000;
  parameter [2:0] mux2         = 3'b001;
  parameter [2:0] mux3         = 3'b010;
  parameter [2:0] mux4         = 3'b011;
  parameter [2:0] mux5         = 3'b101;
    
  reg [31:0] wb_out;
    
    always @ (*)
    begin
        case (wb_mux_sel_reg_in)
            mux1:         wb_out = alu_result_in;
            mux2:         wb_out = lu_output_in;
            mux3:         wb_out = imm_reg_in;
            mux4:  	      wb_out = iadder_out_reg;
            mux5:         wb_out = pc_plus_4_reg_in;
            default:      wb_out = alu_result_in;
        endcase
    end
    
    assign wb_mux_out = wb_out;
    
endmodule
