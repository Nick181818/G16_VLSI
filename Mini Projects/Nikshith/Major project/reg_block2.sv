module reg_block2(
    input clk_in,
    input rst_in,
    input [4:0] rd_addr_in,
    input [31:0] rs1_in,
    input [31:0] rs2_in,
    input [31:0] pc_plus_4_in,
    input branch_taken_in,
    input [31:0] iaddr_in,
    input [3:0] alu_opcode_in,
    input [1:0] load_size_in,
    input load_unsigned_in,
    input ALU_src_in,
    input [2:0] wb_mux_sel_in,
    input [31:0]imm_in,
    input rf_wr_en,
    output reg [31:0] iaddr_reg_o,
    output reg [4:0] rd_addr_reg_o,
    output reg [31:0] rs1_reg_o,
    output reg [31:0] rs2_reg_o,
    output reg [31:0] pc_plus_4_reg_o,
    output reg [2:0] alu_opcode_reg_o,
    output reg [1:0] load_size_reg_o,
    output reg load_unsigned_reg_o,
    output reg alu_src_reg_o,
    output reg [2:0] wb_mux_sel_reg_o,
    output reg [31:0] imm_reg_o,
    output reg rf_wr_en_o
);

always @ (posedge clk_in or posedge rst_in) begin
    if (rst_in) begin
        iaddr_reg_o <= 32'b0;
        rd_addr_reg_o <= 5'b0;
        rs1_reg_o <= 32'b0;
        rs2_reg_o <= 32'b0;
        pc_plus_4_reg_o <= 32'b0;
        alu_opcode_reg_o <= 4'b0;
        load_size_reg_o <= 2'b00;
        load_unsigned_reg_o <= 1'b0;
        alu_src_reg_o <= 1'b0;
        wb_mux_sel_reg_o <= 3'b000;
        imm_reg_o <= 1'b0;
        rf_wr_en_o <= 1'b0;
    end else begin
        iaddr_reg_o <= (branch_taken_in) ? {iaddr_in[31:1], 1'b0} : iaddr_in;
        rd_addr_reg_o <= rd_addr_in;
        rs1_reg_o <= rs1_in;
        rs2_reg_o <= rs2_in;
        pc_plus_4_reg_o <= pc_plus_4_in;
        alu_opcode_reg_o <= alu_opcode_in;
        load_size_reg_o <= load_size_in;
        load_unsigned_reg_o <= load_unsigned_in;
        alu_src_reg_o <= ALU_src_in;
        wb_mux_sel_reg_o <= wb_mux_sel_in;
        imm_reg_o <= imm_in;
        rf_wr_en_o <= rf_wr_en;
    end
end

endmodule
