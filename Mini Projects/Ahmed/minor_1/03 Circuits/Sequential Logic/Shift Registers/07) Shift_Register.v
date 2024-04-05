module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    reg [3:0]q;
    always @(posedge clk)begin
        if(resetn == 1'b0) q=4'b0;
        else begin
            q = {q[2],q[1],q[0],in};
        end
    end
    assign out = q[3];

endmodule

