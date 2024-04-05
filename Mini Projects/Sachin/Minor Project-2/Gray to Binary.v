module gray_to_binary #(
    parameter WIDTH = 8
) (
    input [WIDTH-1:0] gray_in,
    output reg [WIDTH-1:0] binary_out
);

genvar i;
generate
    for (i = 0; i < WIDTH; i = i + 1) begin : GRAY_TO_BINARY_GEN
        always @* begin
            if (i == 0)
                binary_out[i] = gray_in[i];
            else
                binary_out[i] = binary_out[i - 1] ^ gray_in[i]
        end
    end
endgenerate

endmodule

