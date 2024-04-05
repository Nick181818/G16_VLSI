//
//Asynchronous First In First Out
//
// Including following source file used in Designing of FIFO
`include "read_handler.v" 
`include "write_handler.v"
`include "mem_module.v"
`include "bin2gray.v"
`include "synchronizer.v"
`include "gray2bin.v"

module Asynchronous_FIFO
#(
  parameter DATASIZE = 8, // Data Size
  parameter ADDRSIZE = 8, // Taking pointer size 8-bit, As 7 bits Required to represent 90 Memory Location and one extra bit for empty and full conditions 
  parameter DEPTH = 90    // DEPTH Of FIFO Memory
 )
(
  input wr_clk, // Write clock signal (200 MHz)
  input rd_clk, // Read clock signal  (50 MHz)
  input wr_rst, // Active high reset for the Write pointer
  input rd_rst, // Active high reset for the Read pointer
  input wr_en,  // Active high enable signal for write operation
  input rd_en,  // Active high enable signal for write operation
  input [7:0] wr_data,  // 8-bits input data from transmitter
  output [7:0] rd_data, // 8-bits output data for receiver
  output o_fifo_full,   //Signal for FIFO full
  output o_fifo_empty  //Signal for FIFO full
);

// Some wire used in between modules
  wire [ADDRSIZE-1:0] rptr; // Read Pointer Value
  wire [ADDRSIZE-1:0] rptr_b2g; // Binary to gray converted Read pointer 
  wire [ADDRSIZE-1:0] rptr_sync; // Synchronized Read pointer
  wire [ADDRSIZE-1:0] rptr_g2b; // Gray to Binary converted Read pointer
  wire [ADDRSIZE-1:0] wptr; // Write Pointer Value
  wire [ADDRSIZE-1:0] wptr_b2g; // Binary to gray converted Write pointer
  wire [ADDRSIZE-1:0] wptr_sync; // Synchronized Read pointer
  wire [ADDRSIZE-1:0] wptr_g2b; // Gray to Binary converted Read pointer


  // *** Instantiating modules by position of ports *** //

  // FIFO Memory Module
  mem_module #(DATASIZE, ADDRSIZE, DEPTH) FIFO_Memory (wr_en, o_fifo_full, wr_clk, rd_clk, rd_en, wptr, rptr, wr_data, rd_data);
  
  //Module For handling read pointer value and Fifo empty condition 
  read_handler #(ADDRSIZE, DEPTH) Read_handler (rd_en, rd_clk, rd_rst, wptr_g2b, o_fifo_empty, rptr);

  //Module For handling write pointer value and Fifo full condition 
  write_handler #(ADDRSIZE, DEPTH) Write_handler (wr_en, wr_clk, wr_rst, rptr_g2b, o_fifo_full, wptr);

  // Modules used in synchronizing read pointer
  // ---------------------------------------------------------------------------------------------------
  bin2gray #(ADDRSIZE) read_b2g (rptr, rptr_b2g); // Binary to Gray Converter
  synchronizer #(ADDRSIZE) read_pointer (wr_clk, wr_rst, rptr_b2g, rptr_sync); // Dual Flop Synchronizer
  gray2bin #(ADDRSIZE) read_g2b (rptr_sync, rptr_g2b);  // Gray to Binary coverter
  // ---------------------------------------------------------------------------------------------------

  // Modules used in synchronizing read pointer
  // -----------------------------------------------------------------------------------------------------
  bin2gray #(ADDRSIZE) write_b2g (wptr, wptr_b2g);  // Binary to Gray Converter
  synchronizer #(ADDRSIZE) write_pointer (rd_clk, rd_rst, wptr_b2g, wptr_sync);  // Dual Flop Synchronizer
  gray2bin #(ADDRSIZE) write_g2b (wptr_sync, wptr_g2b);  // Gray to Binary coverter
  // -----------------------------------------------------------------------------------------------------

endmodule
