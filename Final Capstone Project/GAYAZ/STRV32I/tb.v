module tb;
  parameter MEM_depth = 64; 
  reg clk ;
  reg rst;
  
  reg [31:0] instr;
  reg [31:0] dm_data_out;

  // Outputs
  wire [31:0] iaddr;
  reg [31:0] dm_data_in;
  wire [31:0] dm_addr;
  wire [3:0] dm_wr_mask;
  wire [31:0]dm_wr_req;
  reg [31:0] instr_mem [0:MEM_depth-1];
  reg [31:0] data_mem [0:MEM_depth-1];
  Riscv_Top dut (
    .clk_in(clk),
    .rst_in(rst),
    .instr(instr),
    .iaddr(iaddr),
    .dm_data_out(dm_data_out),
    .dm_data_in(dm_data_in),
    .dm_addr(dm_addr),
    .dm_wr_mask(dm_wr_mask),
    .dm_wr_req(dm_wr_req)
  );
	integer i;
  
  always #50 clk = ~clk;
  
  initial begin
    clk <= 1;
    rst <= 1;
    for(i=0;i<64;i=i+1)
      begin
        instr_mem[i]  <= 32'b0;
      end
    #100;
    rst <= 0;
    instr_mem [0] <=32'b00000000001001011000010100010011;
    #10;
  end
  always @ (posedge clk)
    begin
      instr <= instr_mem[iaddr];
    end
  always @ (posedge clk)
    begin
      if (dm_wr_req)
        begin
          data_mem[dm_addr[6:0]] <= dm_data_out & {{8{dm_wr_mask[3]}}, {8{dm_wr_mask[2]}}, {8{dm_wr_mask[1]}}, {8{dm_wr_mask[0]}}};
          dm_data_in <= 32'b0;
        end
        else begin
          dm_data_in <= data_mem[dm_addr[6:0]];
          data_mem[dm_addr[6:0]] <= data_mem[dm_addr[6:0]];
        end
    end
    initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  initial begin
    #1000;
    $finish;
  end
endmodule