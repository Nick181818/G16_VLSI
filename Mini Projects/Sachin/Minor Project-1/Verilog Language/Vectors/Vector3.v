module top_module (
    input [4:0] a, b, c, d, e, f,
    output reg [7:0] w, x, y, z
);

    // Concatenate input vectors followed by two 1 bits
    assign {w, x, y, z} = {a[4:0], b[4:0], c[4:0], d[4:0], e[4:0], f[4:0], 2'b11};

endmodule
