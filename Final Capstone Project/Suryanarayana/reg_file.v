

module reg_file (
    input clk_in,
    input rst_in,
    input wr_en_in,
    input [4:0] rs1_addr_in,
    input [4:0] rs2_addr_in,
    input [4:0] rd_addr_in,
    input [31:0] rd_data,
    output [31:0] rs1_o,
    output [31:0] rs2_o
);

 reg [31:0] temp_rs1_data;
 reg [31:0] temp_rs2_data;

 // Declaration of Registers
  reg [31:0] reg_mem [0:31];
 integer i;
 // Writing to a register
 always @ (posedge clk_in)
    begin
        if (rst_in) begin
            for ( i = 0; i < 32; i = i+1)
                begin
                reg_mem[i] <= 32'h0;
                end
        end 
        else if (wr_en_in && rd_addr_in != 0)
        begin
            reg_mem[0] <= 32'b0; 
            reg_mem[rd_addr_in] <= rd_data;
        end
        else 
          reg_mem[rd_addr_in] <= reg_mem[rd_addr_in];  
    end

// Reading from a register
 always @ (posedge clk_in)
  begin
    temp_rs1_data <= reg_mem[rs1_addr_in];
    temp_rs2_data <= reg_mem[rs2_addr_in];
  end

  // Avoiding hazard 
  begin
  assign rs1_o = (rs1_addr_in == rd_addr_in) ? rd_data : temp_rs1_data;
  assign rs2_o = (rs2_addr_in == rd_addr_in) ? rd_data : temp_rs2_data;
  end
endmodule