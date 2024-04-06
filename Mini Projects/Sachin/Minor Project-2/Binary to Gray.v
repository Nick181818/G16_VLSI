module binary_to_gray #(
    parameter WIDTH = 8
) (
    input [WIDTH-1:0] binary_in,
    output reg [WIDTH-1:0] gray_out
);

genvar i;
generate
    for (i = 0; i < WIDTH; i = i + 1) begin : BIN_TO_GRAY_GEN
        always @* begin
            if (i == 0)
                gray_out[i] = binary_in[i];
            else
                gray_out[i] = binary_in[i] ^ binary_in[i - 1];
        end
    end
endgenerate

endmodule