//
// Reg Block 2
//
module reg_block_2 (
    input clk_in,               // Clock Signal
    input rst_in,               // Reset Signal
    input branch_taken_in,      // Branch Taken Signal
    input load_unsigned_in,     // Load Unsigned Data signal 
    input ALU_src_in,           // ALU Source signal
    input imm_in,               // Immediate Data Signal
    input rf_wr_en,             // Register Write Enable
    input [4:0] rd_addr_in,     // Address of Destination Register
    input [31:0] rs1_in,        // Data of Source Register 1
    input [31:0] rs2_in,        // Data of Source Register 2
    input [31:0] pc_plus_4_in,  // Program Counter +4 
    input [31:0] iaddr_in,      // Immediate Adder
    input [3:0] alu_opcode_in,  // ALU Opcode
    input [1:0] load_size_in,   // Size of data to be loaded 
    input [2:0] wb_mux_sel_in,  // Write Back Multiplexer 

    output reg load_unsigned_reg_out,
    output reg ALU_src_reg_out,
    output reg imm_reg_out,
    output reg rf_wr_reg_out,
    output reg [4:0] rd_addr_reg_out,
    output reg [31:0] rs1_reg_out,
    output reg [31:0] rs2_reg_out,
    output reg [31:0] pc_plus_4_reg_out,
    output reg [31:0] iaddr_reg_out,
    output reg [3:0] alu_opcode_reg_out,
    output reg [1:0] load_size_reg_out,
    output reg [2:0] wb_mux_sel_reg_out
);
    
    always @(posedge clk_in)
    begin
        if (rst_in) 
        begin
            load_unsigned_reg_out <= 1'b0;
            ALU_src_reg_out <= 1'b0;
            imm_reg_out <= 1'b0;
            rf_wr_reg_out <= 1'b0;
            rd_addr_reg_out <= 5'b0;
            rs1_reg_out <= 32'b0;
            rs2_reg_out <= 32'b0;
            pc_plus_4_reg_out <= 32'b0;
            iaddr_reg_out <= 32'b0;
            alu_opcode_reg_out <= 4'b0;
            load_size_reg_out <= 2'b0;
            wb_mux_sel_reg_out <= 3'b0;
        end 
        else 
            begin
                load_unsigned_reg_out <= load_unsigned_in;
                ALU_src_reg_out <= ALU_src_in;
                imm_reg_out <= imm_in;
                rf_wr_reg_out <= rf_wr_en;
                rd_addr_reg_out <= rd_addr_in;
                rs1_reg_out <= rs1_in;
                rs2_reg_out <= rs2_in;
                pc_plus_4_reg_out <= pc_plus_4_in;
                iaddr_reg_out <= branch_taken_in ? {iaddr_in[31:1],1'b0} : iaddr_in;
                alu_opcode_reg_out <= alu_opcode_in;
                load_size_reg_out <= load_size_in;
                wb_mux_sel_reg_out <= wb_mux_sel_in;
            end
    end 
endmodule