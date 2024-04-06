module reg_file(
    input clk_in,
    input rst_in,
    input [4:0] rs1_addr_in,
    input [4:0] rs2_addr_in,
    input [4:0] rd_addr_in,
    input [31:0] rd_data,
    input wr_en_in,
    output reg [31:0] rs1_out,
    output reg [31:0] rs2_out
);

// Net type registers
reg [31:0] rs1_data_out;
reg [31:0] rs2_data_out;
reg [31:0] mem [0:31];

integer i;

always @ (posedge clk_in or posedge rst_in) begin
    if (rst_in) begin
        // Reset all memory to 0
        for (i = 0; i <= 31; i=i+1) begin
            mem[i] <= 0;
        end
    end
    else if (wr_en_in && rd_addr_in != 0) begin
        mem[0] <= 32'b0; 
        mem[rd_addr_in] <= rd_data;
    end
    else begin
        // No write operation, just retain the memory content
        mem[rd_addr_in] <= mem[rd_addr_in];  
    end

    // Load data from memory
    rs1_data_out <= mem[rs1_addr_in];
    rs2_data_out <= mem[rs2_addr_in];
end

always @(*) begin
    // Update rs1_out and rs2_out based on conditions
    if (rs1_addr_in == rd_addr_in) begin
        rs1_out = rd_data;
    end else begin
        rs1_out = rs1_data_out;
    end
    
    if (rs2_addr_in == rd_addr_in) begin
        rs2_out = rd_data;
    end else begin
        rs2_out = rs2_data_out;
    end
end

endmodule