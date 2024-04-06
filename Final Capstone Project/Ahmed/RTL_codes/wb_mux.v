module wb_mux (
    input ALU_src_reg_in,
    input [31:0] imm_reg_in,
    input [31:0] rs2_reg_in,
    input [2:0] wb_mux_sel_reg_in,
    input [31:0] ALU_result_in,
    input [31:0] lu_output_in,
    input [31:0] iadder_out_reg_in,
    input [31:0] pc_plus_4_reg_in,
    output [31:0] alu_2nd_src_mux_out,
    output reg [31:0] wb_mux_out
);
    

assign alu_2nd_src_mux_out = ALU_src_reg_in ? rs2_reg_in : imm_reg_in;

always @ (*)
begin
    case (wb_mux_sel_reg_in)
        3'b000 : wb_mux_out = ALU_result_in;
        3'b001 : wb_mux_out = lu_output_in;
        3'b010 : wb_mux_out = imm_reg_in;
        3'b011 : wb_mux_out = iadder_out_reg_in;
        3'b101 : wb_mux_out = pc_plus_4_reg_in;
        default: wb_mux_out = ALU_result_in;
    endcase
end
endmodule