module fifo_write_logic #(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 90,
  parameter PTR_WIDTH = $clog2(FIFO_DEPTH)+1
) (
    input wr_clk,
    input wr_en,
    input [DATA_WIDTH-1:0] wr_data,
    input wr_rst,
    output reg [PTR_WIDTH-1:0] wr_ptr,
    output wire [PTR_WIDTH-1:0] wr_ptr_gray,
    output reg [DATA_WIDTH-1:0] fifo_data_in,
    input full
);

reg [PTR_WIDTH-1:0] wr_ptr_binary;

// Pointer gray code conversion
binary_to_gray #(.WIDTH(PTR_WIDTH)) binary_to_gray_inst (
    .binary_in(wr_ptr),
    .gray_out(wr_ptr_gray)
);

// Synchronizer for wr_ptr_gray
always @(posedge wr_clk) begin
    if (wr_rst) begin
        wr_ptr <= 0;
    end else begin
        wr_ptr <= wr_ptr + 1;
    end
end

// Write logic
always @(posedge wr_clk or posedge wr_rst) begin
    if (wr_rst) begin
        fifo_data_in <= 0; // Reset data on reset
    end else if (wr_en && !full) begin
        fifo_data_in <= wr_data;
    end
end

endmodule
