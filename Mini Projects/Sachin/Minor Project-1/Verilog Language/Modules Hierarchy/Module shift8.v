module top_module (
    input clk,
    input [7:0] d,
    input [1:0] sel,
    output reg [7:0] q
);
    // Interconnections
    wire [7:0] q1, q2, q3;

    // 3 modules
    my_dff8 d1(clk, d, q1);
    my_dff8 d2(clk, q1, q2);
    my_dff8 d3(clk, q2, q3);

    // A mux
    // Dataflow model
    always @(*) begin
        q = (sel == 2'b00) ? d :
            (sel == 2'b01) ? q1 :
            (sel == 2'b10) ? q2 :
            (sel == 2'b11) ? q3 :
                            8'b00000000;
    end
endmodule
