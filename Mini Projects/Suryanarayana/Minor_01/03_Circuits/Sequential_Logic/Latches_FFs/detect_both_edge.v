module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
     wire [7:0]del;
    always @(posedge clk) begin
        del <= in; 
        anyedge <= del ^ in;
 	end
endmodule
