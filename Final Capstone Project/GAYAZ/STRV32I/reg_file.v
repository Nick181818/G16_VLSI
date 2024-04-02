module reg_file (
    input clk_in,
    input rst_in,
    input wr_en_in,
    input [4:0] rs1_adder_in,
    input [4:0] rs2_adder_in,
    input [4:0] rd_adder_in,
    input [31:0] rd_data,
    output [31:0] rs1_out,
    output [31:0] rs2_out
);

 reg [31:0] temp_rs1_data;
 reg [31:0] temp_rs2_data;

 // Declaration of Registers
 reg [31:0] register [0:31];

 // Writing to a register (synchronous write)
 always @ (posedge clk_in)
    begin
        if (wr_en_in && rd_adder_in != 0)
        begin
            register[0] <= 32'b0; 
            register[rd_adder_in] <= rd_data;
        end
        else 
            register[rd_adder_in] <= register[rd_adder_in];  
    end

// Reading from a register (asychronous read)
 always @ (*)
  begin
    temp_rs1_data <= register[rs1_adder_in];
    temp_rs2_data <= register[rs2_adder_in];
  end

  // Avoiding hazard(data forwarding) 
  assign rs1_out = (rs1_adder_in == rd_adder_in) ? rd_data : temp_rs1_data;
  assign rs2_out = (rs2_adder_in == rd_adder_in) ? rd_data : temp_rs2_data;
endmodule