module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);
    reg [7:0]p1;
    
    always@(posedge clk)
        begin
            p1<=in;
            pedge<=in&(~p1);
        end


endmodule
