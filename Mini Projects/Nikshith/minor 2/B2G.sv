module b2g #(parameter N = 8)(
    input [N-1:0] bin_in,
    output [N-1:0] gray_out
);

    // Intermediate signal for storing gray code bits
    reg [N-1:0] gray_intermediate;

    always @* begin
        gray_intermediate[0] = bin_in[0]; // MSB remains unchanged

        // Compute gray code bits using XOR operation
        for (int i = 1; i < N; i++) begin
            gray_intermediate[i] = bin_in[i] ^ bin_in[i-1];
        end
    end

    // Assign intermediate signal to output
    assign gray_out = gray_intermediate;

endmodule
