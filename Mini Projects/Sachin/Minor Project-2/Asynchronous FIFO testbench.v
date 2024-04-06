// Code your testbench here
// or browse Examples

`timescale 1ns / 1ps

module async_fifo_tb;

parameter DATA_WIDTH = 8;
parameter FIFO_DEPTH = 90;

// Clock definitions
reg wr_clk = 1'b0;
reg rd_clk = 1'b0;

// FIFO signals
reg wr_en = 1'b0;
reg [DATA_WIDTH-1:0] wr_data;
reg wr_rst = 1'b0;
reg rd_en = 1'b0;
reg rd_rst = 1'b0;
wire [DATA_WIDTH-1:0] rd_data;
wire o_fifo_full;
wire o_fifo_empty;

// DUT instantiation
fifo #(
  .DATA_WIDTH(DATA_WIDTH),
  .FIFO_DEPTH(FIFO_DEPTH)
) dut (
  .wr_clk(wr_clk),
  .rd_clk(rd_clk),
  .wr_en(wr_en),
  .wr_data(wr_data),
  .wr_rst(wr_rst),
  .rd_en(rd_en),
  .rd_data(rd_data),
  .rd_rst(rd_rst),
  .empty(o_fifo_empty),
  .full(o_fifo_full)
);

// Clock generation (200MHz for write clock, 50MHz for read clock)
initial begin
  // Generate write clock (200MHz)
  forever #5 wr_clk = ~wr_clk;
end

initial begin
  // Generate read clock (50MHz)
  forever #20 rd_clk = ~rd_clk;
end

// Stimulus generation
initial begin
  // Reset both write and read
  wr_rst = 1'b1;
  rd_rst = 1'b1;
  #10;
  wr_rst = 1'b0;
  rd_rst = 1'b0;

  // Write data to FIFO
  repeat (FIFO_DEPTH) begin
    @(posedge wr_clk);
    if (!o_fifo_full) begin
      wr_en = 1'b1;
      wr_data = $random;
    end else begin
      wr_en = 1'b0;
    end
  end

  // Stop writing
  wr_en = 1'b0;

  // Read data from FIFO
  while (!o_fifo_empty) begin
    @(posedge rd_clk);
    rd_en = 1'b1;
  end

  // Stop reading
  rd_en = 1'b0;

  // Check for errors after a delay
  #100;
  if (o_fifo_full) begin
    $display("Error: FIFO full");
  end
  if (!o_fifo_empty) begin
    $display("Error: FIFO empty");
  end

  #100 $finish;
end

// Monitor signals
always @(posedge rd_clk) begin
  if (rd_en) begin
    $display("Read data: %h", rd_data);
  end
end

// Dumpfile for waveform generation
initial begin
  $dumpfile("async_fifo_tb.vcd");
  $dumpvars(0, dut); // Dump all signals of the DUT
end

endmodule