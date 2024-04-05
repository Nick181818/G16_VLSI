module wb_mux(
    input ALU_src_reg_in,
    input [31:0] imm_reg_in,
    input [31:0] rs2_reg_in,
    input [2:0] wb_mux_sel_reg_in,
    input [31:0] ALU_result_in,
    input [31:0] lu_output_in,
    input [31:0] iadder_out_reg_in,
    input [31:0] pc_plus_4_reg_in,
    output [31:0] alu_2_src_mux_out,
    output [31:0] wb_mux_out);

    reg [31:0] wb_mux_out_reg;
    
    assign alu_2_src_mux_out = (ALU_src_reg_in) ? rs2_reg_in : imm_reg_in;
    
    always @* begin
        case(wb_mux_sel_reg_in)
            3'b000: wb_mux_out_reg = ALU_result_in;
            3'b001: wb_mux_out_reg = lu_output_in;
            3'b011: wb_mux_out_reg = iadder_out_reg_in;
            3'b010: wb_mux_out_reg = imm_reg_in;
            3'b101: wb_mux_out_reg = pc_plus_4_reg_in;

            default: wb_mux_out_reg = 32'b0;
        endcase
    end

    assign wb_mux_out = wb_mux_out_reg;
endmodule
