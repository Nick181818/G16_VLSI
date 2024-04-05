module g2b #(parameter N = 8)(
    input [N-1:0] gray_in,
    output [N-1:0] bin_out
);

    // Intermediate signal for storing binary code bits
    reg [N-1:0] bin_intermediate;

    always @* begin
        // MSB of binary output is directly assigned from MSB of gray input
        bin_intermediate[N-1] = gray_in[N-1];

        // Compute binary code bits using XOR operation
        for (int i = N-2; i >= 0; i--) begin
            bin_intermediate[i] = bin_intermediate[i+1] ^ gray_in[i];
        end
    end

    // Assign intermediate signal to output
    assign bin_out = bin_intermediate;

endmodule
