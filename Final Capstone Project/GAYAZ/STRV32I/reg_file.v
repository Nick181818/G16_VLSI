module reg_file(
     input clk_in,//Input clock
     input rst_in,//Input reset
     input [4:0] rs1_addr_in,//5 Bits rs1_adr_in
     input [4:0] rs2_addr_in,//5 Bits rs2_addr_in
     input [4:0] rd_addr_in,//5 Bits rd_addr_in
     input [31:0] rd_data,//32 Bits rd_data
     input wr_en_in,//Input wr_en_in {Taken from wr_en_gnerator}
     output wire [31:0] rs1_out,//32 Bits rs1_out {Wir Type}
     output wire [31:0] rs2_out//32 Bits rs2_out {Wire Type}
     );
  //Declaring connections
  reg [31:0] rs1_data_out;
  reg [31:0] rs2_data_out;
//Declaring Memory
  reg [31:0] Ram [0:31];
  integer i;

 always @ (posedge clk_in)
    begin
      if(rst_in)
      begin
        for(i=0;i<32;i=i+1)
        begin
          Ram[i] <= 32'b0000_0000;
        end
      end
        else if (wr_en_in && rd_addr_in != 0)//Filling Up Memory by given Input data
          begin
            Ram[0]  <=  32'b0000_0000; 
            Ram[rd_addr_in] <=  rd_data;
          end
        else 
          Ram[rd_addr_in]   <=  Ram[rd_addr_in];  
    end

  always @ (posedge clk_in)
    begin
      rs1_data_out  <=  Ram[rs1_addr_in];
      rs2_data_out  <=  Ram[rs2_addr_in];
    end
//Assigning the values of output
  assign rs1_out    =   (rs1_addr_in == rd_addr_in) ? rd_data : rs1_data_out;
  assign rs2_out    =   (rs2_addr_in == rd_addr_in) ? rd_data : rs2_data_out;
  
endmodule
