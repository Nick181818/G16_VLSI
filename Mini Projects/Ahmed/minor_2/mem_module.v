//
// FIFO memory
//
module mem_module
#(
  parameter DATASIZE = 8, // Memory data word width
  parameter ADDRSIZE = 8, // Number of memory address bits
  parameter DEPTH = 90    // Depth of Memoty
)
(
  input   wr_en, // Write Enable signal
  input   wfull, // Fifo full siganl
  input   wr_clk, // Write clock signal
  input   rd_clk, // Read clock signal
  input   rd_en,  // Read Enable signal
  input   [ADDRSIZE-2:0] wr_addr, // Address location to write data
  input   [ADDRSIZE-2:0] rd_addr, // Address location to read data
  input   [DATASIZE-1:0] wr_data, // Input Data to be written
  output reg [DATASIZE-1:0] rd_data // Output Data
);

  // Memory Declaration
  reg [DATASIZE-1:0] mem [0:DEPTH-1];

  // Reading of Data
  always @(posedge rd_clk) begin
   if (rd_en)
    rd_data <= mem[rd_addr];
  else
    rd_data <= rd_data;
  end

  //Writing of Data
  always @(posedge wr_clk)
  begin
    if (wr_en && !wfull)
      mem[wr_addr] <= wr_data;
    else
      mem[wr_addr] <= mem[wr_addr];
  end

endmodule
