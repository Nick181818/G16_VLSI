module tb();

reg clk_in=1'b1;
reg rst_in;
reg [31:0] instr_in;
wire [31:0] dmdata_out;
wire [31:0] imaddr_out;
reg [31:0] dmdata_in;
wire [31:0] dmaddr_out;
wire [3:0] dmwr_mask_out;
wire dmwr_req_out;

reg zero=32'b0;

// Instantiate memory for instruction storage
reg [31:0] instruct_memory [0:63];

// Instantiate memory for data storage
reg [31:0] data_memory [0:63];

// Instantiate RISC-V processor
Riscv_Top dut (
  .clk_in(clk_in),
  .rst_in(rst_in),
  .instr_in(instr_in),
  .imaddr_out(imaddr_out),
  .dmdata_in(dmdata_in),
  .dmaddr_out(dmaddr_out),
  .dmwr_mask_out(dmwr_mask_out),
  .dmwr_req_out(dmwr_req_out),
  .dmdata_out(dmdata_out)
);

// Read instructions from external file and store in instruction memory
initial begin
 
  #10;
//R-Type Instruction 
  //instruct_memory[0]	=	32'h00d60e33;
  //I-Type Instruction 
  //instruct_memory[4]	=	32'h00258513;
  //S-Type Instruction {shift}
 // instruct_memory[8]	=	32'h00c51323;
 // S-Type Instruction {lw}
 //instruct_memory[12]	=	32'h00652683;
  //B-Type Instruction
  //instruct_memory[16]	=	32'h00c56a63;
  //J-Type
 // instruct_memory[20]	=	32'h00160567 ;
  //U-Type
 // instruct_memory[24]	=	32'h12345637;
end

// Testbench clock generation
always #10 clk_in = ~clk_in;

integer i;
// Reset generation
initial begin
  rst_in = 1;
  for(i=0;i<64;i=i+1)
    begin
      instruct_memory[i]  = 32'b0;
    end
  #10;
  rst_in = 0;
end

always @ (posedge clk_in)
  begin
    instr_in <= instruct_memory[imaddr_out[5:0]];
  end

always @ (posedge clk_in)
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