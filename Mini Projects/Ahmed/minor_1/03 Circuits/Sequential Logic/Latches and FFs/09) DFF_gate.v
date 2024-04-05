module top_module (
    input clk,
    input in, 
    output out);

	reg q;
    wire d;
    xor(d, in, q);
	always @ (posedge clk)begin
        q <= d;
    end
    assign out = q;

endmodule
