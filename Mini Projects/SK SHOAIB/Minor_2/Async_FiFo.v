`include "Memory.sv"
`include "dff.sv"
`include "b2g.sv"
`include "g2b.sv"
`include "write.sv"
`include "read.sv"

module asynchronous_fifo #(parameter d=8,depth=90)(
    input wrclk,
    input rdclk,
    input wrrst,
    input rdrst,
    input [7:0] d_in,
    output [7:0] d_out,
    input wren,
    input rden,
    output fifo_full,
    output fifo_empty
    );
    
    wire wrena;
    wire [d-1:0] wrPtr;
    wire [d-1:0] rdPtr;
  
    wire [d-1:0] rg2b;
    wire [d-1:0] wg2b;
  
    wire [d-1:0] rdff;
    wire [d-1:0] wdff;
  
    wire [d-1:0] wb2g;
    wire [d-1:0] rb2g;

   

    
     Memory Fifomem (
      .wrclk(wrclk),
      .rdclk(rdclk),
      .wrPtr(wrPtr),
      .rdPtr(rdPtr),
      .rden(rden),
      .wren(wrena),
      .wrData(d_in),
      .rdData(d_out)
    );
    
  assign wrena= wren & ~fifo_full;
    
    write Writehandler(
      .wrclk(wrclk),
      .wren(wren),
      .wrrst(wrrst),
      .rdPtr(rg2b),
      .wrPtr(wrPtr),
      .fifo_full(fifo_full)
    );
    
    read Readhandler(
      .rdclk(rdclk),
      .rden(rden),
      .rdrst(rdrst),
      .wrPtr(wg2b),
      .rdPtr(rdPtr),
      .fifo_empty(fifo_empty)      
    );
    
    b2g B2GWrite (
        .binary(wrPtr),
        .gray(wb2g)
    );
  
     b2g B2GRead (
        .binary(rdPtr),
        .gray(rb2g)
    );
    
    dff_Synchronizer Write(
      .data_in(wb2g),
      .data_out(wdff),
      .clk(rdclk),
      .rst(rdrst)
    );
  
    dff_Synchronizer Read(
      .data_in(rb2g),
      .data_out(rdff),
      .clk(wrclk),
      .rst(wrrst)
    );

    
    g2b G2BWrite(
      .gray(wdff),
      .binary(wg2b)
    );
  
    g2b G2BRead(
      .gray(rdff),
      .binary(rg2b)
    );
    

endmodule
