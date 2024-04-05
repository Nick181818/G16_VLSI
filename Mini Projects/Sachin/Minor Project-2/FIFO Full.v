module fifo_full #(
    parameter FIFO_DEPTH = 90
) (
    input [$clog2(FIFO_DEPTH):0] wr_ptr_gray_next,
    input [$clog2(FIFO_DEPTH):0] rd_ptr_gray_sync,
    output wire full
);

// Full logic
    assign full = (wr_ptr_gray_next[$clog2(FIFO_DEPTH)] != rd_ptr_gray_sync[$clog2(FIFO_DEPTH)]) &&
      (wr_ptr_gray_next[$clog2(FIFO_DEPTH)-1:0] == rd_ptr_gray_sync[$clog2(FIFO_DEPTH)-1:0]);

endmodule
