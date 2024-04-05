`include "Mem.sv"
`include "Synchronizer.sv"
`include "b2g.sv"
`include "g2b.sv"
`include "wrptr.sv"
`include "rdptr.sv"
module asy_fifo #(parameter N = 8,depth=90)(
    input wr_clk,
    input rd_clk,
    input wr_rst,
    input rd_rst,
  	input [N-1:0] wr_data,
  	output [N-1:0] rd_data,
    input wr_en,
    input rd_en,
    output fifo_Full,
    output fifo_Empty
    );
    
    wire wr_en_Derived;
 	wire [N-1:0] wr_ptr;
  	wire [N-1:0] rd_ptrG2B;
  	wire [N-1:0] rd_ptrDual_Sync_out;
  	wire [N-1:0] wr_ptrB2G;
 	wire [N-1:0] rd_ptr;
 	wire [N-1:0] wr_ptrG2B;
 	wire [N-1:0] wr_ptrDual_Sync_out;
 	wire [N-1:0] rd_ptrB2G;
    
       Mem surya (
         .wr_clk(wr_clk),
         .rd_clk(rd_clk),
         .wr_ptr(wr_ptr),
         .rd_ptr(rd_ptr),
         .rd_en(rd_en),
         .wr_en(wr_en_Derived),
         .wr_data(wr_data),
         .rd_data(rd_data)
    );
    
  and (wr_en_Derived, wr_en, ~fifo_Full);
    
    wrptr surya_uut(
      .wr_clk(wr_clk),
      .wr_en(wr_en),
      .wr_rst(wr_rst),
      .rd_ptr(rd_ptrG2B),
      .wr_ptr(wr_ptr),
      .fifo_Full(fifo_Full)
    );
    
    rdptr surya_ptr(
      .rd_clk(rd_clk),
      .rd_en(rd_en),
      .rd_rst(rd_rst),
      .wr_ptr(wr_ptrG2B),
      .rd_ptr(rd_ptr),
      .fifo_Empty(fifo_Empty)      
    );
    
    b2g surya_w1 (
      .bin_in(wr_ptr),
      .gray_out(wr_ptrB2G)
    );
    
    Synchronizer write_surya(
      .data_in(wr_ptrB2G),
      .data_out(wr_ptrDual_Sync_out),
      .clk(rd_clk),
      .rst(rd_rst)
    );
    
    g2b GB_Write(
      .gray_in(wr_ptrDual_Sync_out),
      .bin_out(wr_ptrG2B)
    );
    
    b2g BG_surya (
      .bin_in(rd_ptr),
      .gray_out(rd_ptrB2G)
    );
    
    Synchronizer read_surya(
      .data_in(rd_ptrB2G),
      .data_out(rd_ptrDual_Sync_out),
      .clk(wr_clk),
      .rst(wr_rst)
    );
    
    g2b surya_w2(
      .gray_in(rd_ptrDual_Sync_out),
      .bin_out(rd_ptrG2B)
    );
           
endmodule