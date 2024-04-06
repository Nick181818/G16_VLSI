module RISC_tb();

  reg clk_in=1'b1;
  reg rst_in;
  reg [31:0] inst_in;
  wire [31:0] dmdata_out;
  wire [31:0] imaddr_out;
  reg [31:0] dmdata_in;
  wire [31:0] dmaddr_out;
  wire [3:0] dmwr_mask_out;
  wire dmwr_req_out;
  
  reg zero=32'b0;

  // Instantiate memory for instruction storage
  reg [31:0] inst_mem [0:63];

  // Instantiate memory for data storage
  reg [31:0] data_mem [0:63];

  // Instantiate RISC-V processor
  
  RISC_TOP dut (
    .clk_in(clk_in),
    .rst_in(rst_in),
    .inst_in(inst_in),
    .dmwr_mask_out(dmwr_mask_out),
    .imaddr_out(imaddr_out),
    .dmdata_in(dmdata_in),
    .dmaddr_out(dmaddr_out),
    .dmwr_req_out(dmwr_req_out),
    .dmdata_out(dmdata_out)
  );

  // Read instructions from external file and store in instruction memory
  initial begin
   
    #10;
    inst_mem[0] 	=	32'h00d60e33;//R-Type
    inst_mem[4] 	=	32'h00258513;//I-Type
    inst_mem[8]  	=	32'h00c51323;//S-Type
    inst_mem[12]	=	32'h00c56a63;//B-Type
    inst_mem[16]	=	32'h00160567;//J-Type
    inst_mem[20]	=	32'h12345637;//U-Type
 end

  // Testbench clock generation
  always #5 clk_in = ~clk_in;

  integer i;
  // Reset generation
  initial begin
    rst_in = 1;
    for(i=0;i<64;i=i+1)
      begin
        inst_mem[i]  = 32'b0;
      end
    #10;
    rst_in = 0;
  end

  always @ (posedge clk_in)
    begin
      inst_in <= inst_mem[imaddr_out[5:0]];
    end
  
  always @ (posedge clk_in)
    begin
      if(dmwr_req_out)
        begin
          data_mem[dmaddr_out[5:0]] <= dmdata_out & {{8{dmwr_mask_out[3]}}, {8{dmwr_mask_out[2]}}, {8{dmwr_mask_out[1]}}, {8{dmwr_mask_out[0]}}};
          dmdata_in <= 1'b0;
        end
      
      else
        begin 
          dmdata_in <= data_mem[dmaddr_out[5:0]];
          data_mem[dmaddr_out[5:0]] <= data_mem[dmaddr_out[5:0]];
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