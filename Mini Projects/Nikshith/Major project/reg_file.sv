module reg_file (
    input clk_in,
    input rst_in,
    input wr_en_in,
    input [4:0] rs1_addr_in,
    input [4:0] rs2_addr_in,
    input [4:0] rd_addr_in,
    input [31:0] rd_data,
    input [4:0] wr_in,
    input  wr_en,
    output reg [31:0] rs1_o,
    output reg [31:0] rs2_o
);

// Declaration of Registers
reg [31:0] reg_mem [0:31];

// Writing to a register
always @ (posedge clk_in) begin
    if (rst_in) begin
        for (integer i = 0; i < 32; i = i + 1) begin
            reg_mem[i] <= 32'h0;
        end
    end else if (wr_en_in && (rd_addr_in != 0)) begin
        reg_mem[rd_addr_in] <= rd_data;
    end
end

// Reading from a register
always @ (posedge clk_in) begin
    rs1_o <= (rs1_addr_in == rd_addr_in) ? rd_data : reg_mem[rs1_addr_in];
    rs2_o <= (rs2_addr_in == rd_addr_in) ? rd_data : reg_mem[rs2_addr_in];
end

endmodule
