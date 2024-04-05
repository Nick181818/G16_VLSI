
module test();

  reg clk=1'b1;
  reg rst;
  reg [31:0] instr_in;
  wire [31:0] dm_data_out;
  wire [31:0] im_addr_out;
  reg [31:0] dm_data_in;
  wire [31:0] dm_addr_out;
  wire [3:0] dm_wr_mask_out;
  wire dm_wr_req_out;
  
  reg zero=32'b0;

  // Instantiate memory for instruction storage
  reg [31:0] instruct_memory [0:63];

  // Instantiate memory for data storage
  reg [31:0] data_memory [0:63];

  // Instantiate RISC-V processor
  top dut (
    .clk(clk),
    .rst(rst),
    .instr_in(instr_in),
    .im_addr_out(im_addr_out),
    .dm_data_in(dm_data_in),
    .dm_addr_out(dm_addr_out),
    .dm_wr_mask_out(dm_wr_mask_out),
    .dm_wr_req_out(dm_wr_req_out),
    .dm_data_out(dm_data_out)
  );

  // Read instructions from external file and store in instruction memory
  initial begin
    //$readmemh("2.data", instruct_memory);
    #10;
      instruct_memory[0]  <= 32'b00000000010000011000000000110011; // R-Type (add)
      instruct_memory[4]  <= 32'b0;
      instruct_memory[8]  <= 32'b00000000011100101000000010010011; // I-Type(addi)
      instruct_memory[12] <= 32'b0;
      instruct_memory[16] <= 32'b00000000101001001001001110100011; // S-Type(sh)
      instruct_memory[20] <= 32'b0;
      instruct_memory[24] <= 32'b00000000010100110010010100000011; // L-Type(lw)
      instruct_memory[28] <= 32'b0;
      instruct_memory[32] <= 32'b00000000101001001110100001100011; // B-Type(bltu)
      instruct_memory[36] <= 32'b0;
      instruct_memory[40] <= 32'b00000000000101010000010011100111; // J-Type(jalr)
      instruct_memory[44] <= 32'b0;
      instruct_memory[52] <= 32'b01010110011110001001011010110111; // U-Type(lui)
    //instruct_memory[56] <= 32'b0;  
  end

  // Testbench clock generation
  always #50 clk = ~clk;
  integer i;

  // Reset generation
  initial begin
    rst = 1;
    for(i=0;i<64;i=i+1)
      begin
        instruct_memory[i] = 32'h0;
      end 
    #100;
    rst = 0;
    #10;
  end

  always @ (posedge clk)
    begin
      instr_in <= instruct_memory[im_addr_out[5:0]];
    end
  
  always @ (posedge clk)
    begin
      if(dm_wr_req_out)
        begin
          data_memory[dm_addr_out[5:0]] <= dm_data_out & {{8{dm_wr_mask_out[3]}}, {8{dm_wr_mask_out[2]}}, {8{dm_wr_mask_out[1]}}, {8{dm_wr_mask_out[0]}}};
          dm_data_in <= zero;
        end
      
      else
        begin 
          dm_data_in <= data_memory[dm_addr_out[5:0]];
          data_memory[dm_addr_out[5:0]] <= data_memory[dm_addr_out[5:0]];
        end
    end

    initial 
      begin
        $dumpfile("dump.vcd");
        $dumpvars;
      end 
  
  initial 
    begin
      #4000;
      $finish;
    end

endmodule
