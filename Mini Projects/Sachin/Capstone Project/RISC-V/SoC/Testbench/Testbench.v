`timescale 1ns/1ps

module Testbench();

  reg clk=1'b1;
  reg rst;
  reg [31:0] instr_in;
  wire [31:0] dmdata_out;
  wire [31:0] imaddr_out;
  reg [31:0] dmdata_in;
  wire [31:0] dmaddr_out;
  wire [3:0] dmwr_mask_out;
  wire dmwr_req_out;
  
  reg [31:0] zero=32'h0;

  // Instantiate memory for instruction storage
  reg [31:0] instruct_memory [0:63];

  // Instantiate memory for data storage
  reg [31:0] data_memory [0:63];

  // Instantiate RISC-V processor
  Topmodule dut (
    .clk(clk),
    .rst(rst),
    .instr_in(instr_in),
    .imaddr_out(imaddr_out),
    .dmaddr_out(dmaddr_out),
    .dmwr_mask_out(dmwr_mask_out),
    .dmwr_req_out(dmwr_req_out),
    .dmdata_out(dmdata_out)
  );

  // Read instructions from external file and store in instruction memory
  initial begin
    $readmemh("2.data", instruct_memory);
  end

  // Testbench clock generation
  always #5 clk = ~clk;

  // Reset generation
  initial begin
    rst = 1;
    #10;
    rst = 0;
  end

  always @ (posedge clk)
    begin
      instr_in <= instruct_memory[imaddr_out[5:0]];
    end
  
  always @ (posedge clk)
    begin
      if(dmwr_req_out)
        begin
          data_memory[dmaddr_out[5:0]] <= dmdata_out & {{8{dmwr_mask_out[3]}}, {8{dmwr_mask_out[2]}}, {8{dmwr_mask_out[1]}}, {8{dmwr_mask_out[0]}}};
          dmdata_in <= zero;
        end
      
      else
        begin 
          dmdata_in <= data_memory[dmaddr_out[5:0]];
          data_memory[dmaddr_out[5:0]] <= data_memory[dmaddr_out[5:0]];
        end
    end

    initial 
      begin
        $dumpfile("dump.vcd");
        $dumpvars;
      end 
  
  initial 
    begin
      #500;
      $finish;
    end

endmodule