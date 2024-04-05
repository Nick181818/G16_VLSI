module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    MUXDFF U3(.R(SW[3]), .in(KEY[3]), .L(KEY[2]), .E(KEY[1]), .clk(KEY[0]), .Q(LEDR[3]) );
    MUXDFF U2(.R(SW[2]), .in(LEDR[3]), .L(KEY[2]), .E(KEY[1]), .clk(KEY[0]), .Q(LEDR[2]) );
    MUXDFF U1(.R(SW[1]), .in(LEDR[2]), .L(KEY[2]), .E(KEY[1]), .clk(KEY[0]), .Q(LEDR[1]) );
    MUXDFF U0(.R(SW[0]), .in(LEDR[1]), .L(KEY[2]), .E(KEY[1]), .clk(KEY[0]), .Q(LEDR[0]) );

endmodule

module MUXDFF (input R, in, L, E, clk, output reg Q);
    wire [1:0]MO;
    assign MO[0]= E?in:Q;
    assign MO[1]= L?R:MO[0];
    always @(posedge clk)begin
        Q=MO[1];
    end

endmodule

