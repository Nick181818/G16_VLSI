module Synchronizer #(parameter N = 8)(
    input [N-1:0] data_in,
    output reg [N-1:0] data_out,
    input clk,
    input rst
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data_out <= '0;
        end else begin
            data_out <= data_in;
        end
    end

endmodule
