module AsynchronousFIFO(
    input wr_clk,
    input wr_en,
    input wr_rst,
    input rd_clk,
    input rd_rst,
    input rd_en,
    input [DATAWIDTH-1:0]wr_data,
    input [DATAWIDTH-1:0]rd_data,
    output o_fifo_full,
output o_fifo_empty
);
parameter FIFODEPTH=90;
parameter DATAWIDTH=8;
parameter PTRWIDTH=8;
reg[DATAWIDTH-1:0] memory[FIFODEPTH-1:0];
reg[PTRWIDTH-1:0]rd_ptr;
reg[PTRWIDTH-1:0]wr_ptr;
reg o_fifo_full;
reg o_fifo_empty;
endmodule