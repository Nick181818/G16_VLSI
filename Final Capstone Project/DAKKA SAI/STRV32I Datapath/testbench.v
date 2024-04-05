module processor_tb;
  parameter MEM_depth = 100; 
  reg clk ;
  reg rst;
  
  reg [31:0] instr;
  reg [31:0] dm_data_o;

  // Outputs
  wire [31:0] iaddr;
  wire [31:0] dm_data_in;
  wire [31:0] dm_addr;
  wire [3:0] dm_wr_mask;
  wire [31:0]dm_wr_req;
  reg [31:0] instr_mem [0:MEM_depth-1];
  reg [31:0] data_mem [0:MEM_depth-1];
  top_module uut (
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

  always #50 clk = ~clk;
  initial begin
    #100;
    instr_mem [0] =32'b00000000001001011000010100010011;
    instr_mem [4] =32'b00000000010001000000001100010011;
    instr_mem [8] =32'b00000001001010000100011010110011;
    instr_mem [12] =32'b00000000101101010101001100110011;
    instr_mem [10]=32'b01000000101101010101001100110011;
    instr_mem [14]=32'b00000000101101010111001100110011;
    end
  integer i;
  initial begin
    clk=1;
    rst = 1;
    for(i=0;i<100;i=i+1)
      begin
        instr_mem[i]  = 32'b0;
      end
    #100;
    rst = 0; 
  end
  always @ (posedge clk)
    begin
      instr <= instr_mem[iaddr];
    end
  always @ (posedge clk)
    begin
      if (dm_wr_req)
        begin
          data_mem[dm_addr[6:0]] <= dm_data_in & {{8{dm_wr_mask[3]}}, {8{dm_wr_mask[2]}}, {8{dm_wr_mask[1]}}, {8{dm_wr_mask[0]}}};
          dm_data_o <= 32'b0;
        end
        else begin
          dm_data_o <= data_mem[dm_addr];
          data_mem[dm_addr[6:0]] <= data_mem[dm_addr[6:0]];
        end
    end
    initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  initial begin
    #2000;
    $finish;
  end
endmodule
