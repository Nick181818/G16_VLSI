`include "fifoMemory.sv"
`include "dualFlopSync.sv"
`include "b2g.sv"
`include "g2b.sv"
`include "write.sv"
`include "read.sv"
module ASYNC_FIFO#(parameter N = 8)(
    input wr_clk,
    input rd_clk,
    input wr_rst,
    input rd_rst,
    input [7:0] wr_data,
    output [7:0] rd_data,
    input wr_en,
    input rd_en,
    output o_fifo_full,
    output o_fifo_empty
    );
    
    wire wr_enDerived;
    wire [N-1:0] wrPtr;
    wire [N-1:0] rdPtrG2B;
    wire [N-1:0] rdPtrDualFlopSyncOut;
    wire [N-1:0] wrPtrB2G;
    wire [N-1:0] rdPtr;
    wire [N-1:0] wrPtrG2B;
    wire [N-1:0] wrPtrDualFlopSyncOut;
    wire [N-1:0] rdPtrB2G;
    
    fifoMemory uutFifoMemory (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .wrPtr(wrPtr),
        .rdPtr(rdPtr),
      	.rd_en(rd_en),
        .wr_en(wr_enDerived),
        .wr_data(wr_data),
        .rd_data(rd_data)
    );
    
  and (wr_enDerived, wr_en, ~o_fifo_full);
    
    write uutWrit(
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .wr_rst(wr_rst),
        .rdPtr(rdPtrG2B),
        .wrPtr(wrPtr),
        .o_fifo_full(o_fifo_full)
    );
    
    read uutRead(
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rd_rst(rd_rst),
        .wrPtr(wrPtrG2B),
        .rdPtr(rdPtr),
        .o_fifo_empty(o_fifo_empty)      
    );
    
    b2g uutb2gWrite (
        .binaryIn(wrPtr),
        .grayOut(wrPtrB2G)
    );
    
    dualFlopSync uutDualFlopSyncWrite(
        .dataIn(wrPtrB2G),
        .dataOut(wrPtDualFlopSyncOut),
        .clk(rd_clk),
        .rst(rd_rst)
    );
    
    g2b uutg2bWrite(
        .grayIn(wrPtDualFlopSyncOut),
        .binaryOut(wrPtrG2B)
    );
    
    b2g uutb2gRead (
        .binaryIn(rdPtr),
        .grayOut(rdPtrB2G)
    );
    
    dualFlopSync uutDualFlopSyncRead(
        .dataIn(rdPtrB2G),
        .dataOut(rdPtDualFlopSyncOut),
        .clk(wr_clk),
        .rst(wr_rst)
    );
    
    g2b uutg2bRead(
        .grayIn(rdPtDualFlopSyncOut),
        .binaryOut(rdPtrG2B)
    );
           
endmodule