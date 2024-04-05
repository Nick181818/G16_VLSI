module fifo_empty #(
    parameter FIFO_DEPTH = 90
) (
    input [$clog2(FIFO_DEPTH):0] wr_ptr_gray_sync,
    input [$clog2(FIFO_DEPTH):0] rd_ptr_gray_next,
    output wire empty
);

// Empty logic
    assign empty = (wr_ptr_gray_sync[$clog2(FIFO_DEPTH)] == rd_ptr_gray_next[$clog2(FIFO_DEPTH)]) &&
      (wr_ptr_gray_sync[$clog2(FIFO_DEPTH)-1:0] == rd_ptr_gray_next[$clog2(FIFO_DEPTH)-1:0]);

endmodule