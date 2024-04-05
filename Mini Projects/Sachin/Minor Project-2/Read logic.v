module fifo_read_logic #(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 90,
    parameter PTR_WIDTH = $clog2(FIFO_DEPTH)+1
) (
    input rd_clk,
    input rd_en,
    input rd_rst,
    output reg [PTR_WIDTH-1:0] rd_ptr,
    output wire [PTR_WIDTH-1:0] rd_ptr_gray,
    input [DATA_WIDTH-1:0] fifo_data_out, // Use the output from the dual-port RAM
    output reg [DATA_WIDTH-1:0] rd_data,
    input empty
);
reg [PTR_WIDTH-1:0] rd_ptr_binary;
reg [PTR_WIDTH-1:0] rd_ptr_gray_sync;
reg [PTR_WIDTH-1:0] rd_ptr_bin_sync;

// Pointer gray code conversion
binary_to_gray #(.WIDTH(PTR_WIDTH)) binary_to_gray_inst (
    .binary_in(rd_ptr),
    .gray_out(rd_ptr_gray)
);

// Synchronizer for rd_ptr_gray
always @(posedge rd_clk) begin
    if (rd_rst) begin
        rd_ptr_gray_sync <= 'b0;
    end else begin
        rd_ptr_gray_sync <= rd_ptr_gray;
    end
end

// Gray to binary conversion (for synchronized pointer)
gray_to_binary #(.WIDTH(PTR_WIDTH)) gray_to_binary_inst (
    .gray_in(rd_ptr_gray_sync),
    .binary_out(rd_ptr_bin_sync)
);

// Read logic
always @(posedge rd_clk or posedge rd_rst) begin
    if (rd_rst) begin
        rd_ptr <= 0;
    end else if (rd_en && !empty) begin
        rd_data <= fifo_data_out;
        rd_ptr <= rd_ptr + 1;
    end
end

endmodule
