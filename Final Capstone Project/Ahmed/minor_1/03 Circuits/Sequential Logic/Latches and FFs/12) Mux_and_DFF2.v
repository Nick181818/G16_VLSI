module top_module (
    input clk,
    input w, R, E, L,
    output reg Q
);
	wire mux1_out, d;
    assign mux1_out = E?w:Q;
    assign d = L?R:mux1_out;

	always @ (posedge clk)begin
        Q <= d;
    end
    
endmodule