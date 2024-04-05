module dual_flip_flop_sync #(
    parameter WIDTH = 1
) (
    input clk,
    input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
);

reg [WIDTH-1:0] stage1;
reg [WIDTH-1:0] stage2;

always @(posedge clk) begin 
    stage1 <= data_in;
    stage2 <= stage1;
    data_out <= stage2;
end

endmodule