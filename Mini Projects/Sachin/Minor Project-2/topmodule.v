module Asynchronous_fifo #(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 90,
  parameter PTR_WIDTH = $clog2(FIFO_DEPTH)+1
) (
    input rd_clk,
    input wr_clk,
    input rd_en,
    input wr_en,
    input wr_rst,
    input rd_rst,
    input [DATA_WIDTH-1:0] wr_data,
    output [DATA_WIDTH-1:0] rd_data,
    output empty,
    output full
);

wire [PTR_WIDTH-1:0] rd_ptr_gray;
wire [PTR_WIDTH-1:0] wr_ptr_gray;
wire [PTR_WIDTH-1:0] wr_ptr_gray_next;
wire [PTR_WIDTH-1:0] rd_ptr_gray_sync;
wire [PTR_WIDTH-1:0] rd_ptr_gray_next;
wire [PTR_WIDTH-1:0] wr_ptr_gray_sync;
wire [DATA_WIDTH-1:0] fifo_data_in;
wire [DATA_WIDTH-1:0] fifo_data_out;

fifo_read_logic #(
    .DATA_WIDTH(DATA_WIDTH),
    .FIFO_DEPTH(FIFO_DEPTH),
    .PTR_WIDTH(PTR_WIDTH)
) fifo_read_logic_inst (
    .rd_clk(rd_clk),
    .rd_en(rd_en),
    .rd_rst(rd_rst),
    .rd_ptr(rd_ptr),
    .rd_ptr_gray(rd_ptr_gray),
    .fifo_data_out(fifo_data_out),
    .rd_data(rd_data),
    .empty(empty)
);

fifo_write_logic #(
    .DATA_WIDTH(DATA_WIDTH),
    .FIFO_DEPTH(FIFO_DEPTH),
    .PTR_WIDTH(PTR_WIDTH)
) fifo_write_logic_inst (
    .wr_clk(wr_clk),
    .wr_en(wr_en),
    .wr_data(wr_data),
    .wr_rst(wr_rst),
    .wr_ptr(wr_ptr),
    .wr_ptr_gray(wr_ptr_gray),
    .fifo_data_in(fifo_data_in),
    .full(full)
);

dual_flip_flop_sync #(
    .WIDTH(PTR_WIDTH)
) sync_wr_ptr (
    .clk(rd_clk),
    .data_in(wr_ptr_gray),
    .data_out(wr_ptr_gray_sync)
);

dual_flip_flop_sync #(
    .WIDTH(PTR_WIDTH)
) sync_rd_ptr (
    .clk(wr_clk),
    .data_in(rd_ptr_gray),
    .data_out(rd_ptr_gray_sync)
);

gray_to_binary #(
    .WIDTH(PTR_WIDTH)
) gray_to_binary_rd_ptr_inst (
    .gray_in(rd_ptr_gray),
    .binary_out(rd_ptr_gray_next)
);

gray_to_binary #(
    .WIDTH(PTR_WIDTH)
) gray_to_binary_wr_ptr_inst (
    .gray_in(wr_ptr_gray),
    .binary_out(wr_ptr_gray_next)
);

fifo_empty #(
    .FIFO_DEPTH(FIFO_DEPTH)
) fifo_empty_inst (
    .wr_ptr_gray_sync(wr_ptr_gray_sync),
    .rd_ptr_gray_next(rd_ptr_gray_next),
    .empty(empty)
);

fifo_full #(
    .FIFO_DEPTH(FIFO_DEPTH)
) fifo_full_inst (
    .wr_ptr_gray_next(wr_ptr_gray_next),
    .rd_ptr_gray_sync(rd_ptr_gray_sync),
    .full(full)
);
  
dual_port_ram #(
    .DATA_WIDTH(DATA_WIDTH),
    .FIFO_DEPTH(FIFO_DEPTH),
    .PTR_WIDTH(PTR_WIDTH)
) fifo_ram (
    .wr_clk(wr_clk),
    .rd_clk(rd_clk),
    .wr_addr(wr_ptr_binary), 
    .rd_addr(rd_ptr_bin_sync),
    .wr_data(fifo_data_in),
    .wr_en(wr_en && !full), // Write enable when not full
    .rd_data(fifo_data_out)
);

endmodule