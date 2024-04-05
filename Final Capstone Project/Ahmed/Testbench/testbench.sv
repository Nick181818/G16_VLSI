// Code your testbench here
// or browse Examples
//`include "File_name.data"
module test_env;

// Parameters
parameter MEM_DEPTH = 100; // Depth of memory

// Inputs
reg clk = 1;
reg rst;

reg [31:0] instr;
reg [31:0] dm_data_in;

// Outputs
wire [31:0] iaddr;
wire [31:0] dm_data_out;
wire [31:0] dm_addr;
wire [3:0] dm_wr_mask;
wire dm_wr_req;

// Instantiate memory for instruction storage
reg [31:0] instruction_memory [0:MEM_DEPTH-1];

// Instantiate memory for data storage
reg [31:0] data_memory [0:MEM_DEPTH-1];

// Instantiate RISC-V processor
STRV32I dut (
  .clk(clk),
  .rst(rst),
  .instr(instr),
  .iaddr(iaddr),
  .dm_data_in(dm_data_in),
  .dm_data_out(dm_data_out),
  .dm_addr(dm_addr),
  .dm_wr_mask(dm_wr_mask),
  .dm_wr_req(dm_wr_req)
);


// Testbench clock generation
always #5 clk = ~clk;

// Reset generation
initial begin
  rst = 1;    
  for (int i=0; i<99; i = i+1)
    instruction_memory[i] <= 32'h0;
  #5;
  rst = 0;
end

initial begin
  #10;
  instruction_memory[0] <= 32'h0;
  instruction_memory[4] <= 32'h00a88813;
  instruction_memory[8] <= 32'h0;
  instruction_memory[12] <= 32'h0;
  instruction_memory[16] <= 32'h00588913;
  instruction_memory[20] <= 32'h0;
  instruction_memory[24] <= 32'h0;
  instruction_memory[28] <= 32'h01094463;
  instruction_memory[32] <= 32'h0;
  instruction_memory[36] <= 32'h0;
  instruction_memory[40] <= 32'h01282423;
  instruction_memory[44] <= 32'h0;
  instruction_memory[48] <= 32'h0;
  instruction_memory[52] <= 32'h01094463;
  instruction_memory[56] <= 32'h0;
  instruction_memory[60] <= 32'h0;
  instruction_memory[64] <= 32'hff6ff4b7;
  instruction_memory[68] <= 32'h0;
  instruction_memory[72] <= 32'h0;
  //#20;
end

always @ (posedge clk)
  begin
    instr <= instruction_memory[iaddr];
  end

always @ (posedge clk)
  begin
    if (dm_wr_req)
      begin
        data_memory[dm_addr[6:0]] <= dm_data_out & {{8{dm_wr_mask[3]}}, {8{dm_wr_mask[2]}}, {8{dm_wr_mask[1]}}, {8{dm_wr_mask[0]}}};
        dm_data_in <= 32'b0;
      end
      else begin
        dm_data_in <= data_memory[dm_addr];
        data_memory[dm_addr[6:0]] <= data_memory[dm_addr[6:0]];
      end
  end

  // VCD Files
  initial begin
  $dumpfile("dump.vcd");
  $dumpvars;
end

initial begin
  #500;
  $finish;
end

endmodule
