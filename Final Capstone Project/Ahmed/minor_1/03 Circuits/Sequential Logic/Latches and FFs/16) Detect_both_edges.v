module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);
    reg [7:0] d_last;

        always @(posedge clk) begin
            d_last <= in;			// Remember the state of the previous cycle
            anyedge <= in ^ d_last;	// A positive edge occurred if input was 0 and is now 1.
        end
endmodule

