module dual_port_ram #(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 90,
    parameter PTR_WIDTH = $clog2(FIFO_DEPTH)+1
) (
    input wr_clk,
    input rd_clk,
    input [PTR_WIDTH-1:0] wr_addr,
    input [PTR_WIDTH-1:0] rd_addr,
    input [DATA_WIDTH-1:0] wr_data,
    input wr_en,
    output reg [DATA_WIDTH-1:0] rd_data
);

reg [DATA_WIDTH-1:0] mem [0:FIFO_DEPTH-1];

always @(posedge wr_clk) begin
    if (wr_en) begin
        mem[wr_addr] <= wr_data;
    end
end

always @(posedge rd_clk) begin
    rd_data <= mem[rd_addr];
end

endmodule