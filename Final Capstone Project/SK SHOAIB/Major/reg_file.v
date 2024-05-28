module reg_file(
  
  input clk_in,
  input rst_in,
  input [4:0] rs1_addr_in,
  input [4:0] rs2_addr_in,
  input [4:0] rd_addr_in,
  input [31:0] rd_data,
  input wr_en_in,
  output [31:0] rs1_out,
  output [31:0] rs2_out

);
  

  reg [31:0] rs1_data_out;
  reg [31:0] rs2_data_out;

  reg [31:0] mem [0:31];

 always @ (posedge clk_in)
    begin
        if (wr_en_in && rd_addr_in != 0)
          begin
            mem[0] <= 32'b0; 
            mem[rd_addr_in] <= rd_data;
          end
        else 
          mem[rd_addr_in] <= mem[rd_addr_in];  
    end


  always @ (posedge clk_in)
    begin
      rs1_data_out <= mem[rs1_addr_in];
      rs2_data_out <= mem[rs2_addr_in];
    end

  assign rs1_out = (rs1_addr_in == rd_addr_in) ? rd_data : rs1_data_out;
  assign rs2_out = (rs2_addr_in == rd_addr_in) ? rd_data : rs2_data_out;
  
  
endmodule

