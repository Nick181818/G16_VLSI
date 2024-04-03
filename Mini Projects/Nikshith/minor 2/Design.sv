`include "Mem.sv"
`include "Synchronizer.sv"
`include "b2g.sv"
`include "g2b.sv"
`include "wrptr.sv"
`include "rdptr.sv"

module asy_fifo #(parameter N = 8, depth = 90)(
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

    wire [N-1:0] wr_ptr;
    wire [N-1:0] rd_ptr;

    Mem mem_inst (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .wr_ptr(wr_ptr),
        .rd_ptr(rd_ptr),
        .rd_en(rd_en),
        .wr_en(wr_en & ~fifo_Full), // Derive wr_en_Derived
        .wr_data(wr_data),
        .rd_data(rd_data)
    );

    // Assign wr_en_Derived
    assign wr_en_Derived = wr_en & ~fifo_Full;

    // Write pointer logic
    wrptr wrptr_inst (
        .wr_clk(wr_clk),
        .wr_en(wr_en),
        .wr_rst(wr_rst),
        .rd_ptr(rd_ptr),
        .wr_ptr(wr_ptr),
        .fifo_Full(fifo_Full)
    );

    // Read pointer logic
    rdptr rdptr_inst (
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .rd_rst(rd_rst),
        .wr_ptr(wr_ptr),
        .rd_ptr(rd_ptr),
        .fifo_Empty(fifo_Empty)
    );

    // Write pointer conversion from binary to gray
    b2g wr_ptr_conv (
        .bin_in(wr_ptr),
        .gray_out(wr_ptr)
    );

    // Write pointer synchronization
    Synchronizer wr_sync (
        .data_in(wr_ptr),
        .data_out(wr_ptr),
        .clk(rd_clk),
        .rst(rd_rst)
    );

    // Read pointer conversion from gray to binary
    g2b rd_ptr_conv (
        .gray_in(rd_ptr),
        .bin_out(rd_ptr)
    );

    // Read pointer synchronization
    Synchronizer rd_sync (
        .data_in(rd_ptr),
        .data_out(rd_ptr),
        .clk(wr_clk),
        .rst(wr_rst)
    );

endmodule
