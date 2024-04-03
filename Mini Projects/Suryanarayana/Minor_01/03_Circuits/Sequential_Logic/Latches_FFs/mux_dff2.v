module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    wire w1,d;
    assign w1= E ? w : Q;
    assign d = L ? R : w1;
    always @(posedge clk) begin
        Q <= d;
    end
endmodule
