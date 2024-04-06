module processor_tb;

  // Parameters
  parameter MEM_depth = 100; 
  
  // Inputs
  reg clk;
  reg rst;
  
  // Outputs
  wire [31:0] iaddr;
  wire [31:0] dm_data_o;
  wire [31:0] dm_data_in;
  wire [31:0] dm_addr;
  wire [31:0] dm_wr_mask;
  wire dm_wr_req;
  reg [31:0] instr; // Declare instr as reg type

  // Instantiate top_module
  processor_top Nick (
    .clk(clk),
    .rst(rst),
    .instr(instr),
    .iaddr(iaddr),
    .dm_data_o(dm_data_o),
    .dm_data_in(dm_data_in),
    .dm_addr(dm_addr),
    .dm_wr_mask(dm_wr_mask),
    .dm_wr_req(dm_wr_req)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Initialize memories
  reg [31:0] instruction_memory [0:MEM_depth-1];
  reg [31:0] data_memory [0:MEM_depth-1];

  // Initial block to load instruction memory
  initial begin
    instruction_memory[0]=32'b00000000001001011000010100010011;
    instruction_memory[4]=32'b00000000010001000000001100010011;

    // Other initializations
    clk = 0;
    rst = 1;
    #10;
    rst = 0;
    
    // Dump VCD file
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  // Always block to fetch instruction
  always @(posedge clk) begin
    instr <= instruction_memory[iaddr];
  end
  
  // Always block for data memory operations
  always @(posedge clk) begin
    if (dm_wr_req) begin
      data_memory[dm_addr[6:0]] <= dm_data_in & {{8{dm_wr_mask[3]}}, {8{dm_wr_mask[2]}}, {8{dm_wr_mask[1]}}, {8{dm_wr_mask[0]}}};
    end
    
    else 
        begin
      
      data_memory[dm_addr[6:0]] <= data_memory[dm_addr[6:0]];
    end
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  // Simulation termination
  initial begin
    #500;
    $finish;
  end

endmodule