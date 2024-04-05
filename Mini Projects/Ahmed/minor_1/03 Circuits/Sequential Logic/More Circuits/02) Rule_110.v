module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q );
    
    always @ (posedge clk)
        begin
            if (load) q <=data;
            else begin
                // From Kmap center nextstate = ~center&left |  center&~left | ~right&left
                q <= (~q&{q[510:0],1'b0}) | (q&~{q[510:0],1'b0}) | (~{1'b0,q[511:1]}&{q[510:0],1'b0});
            end
        end
    

endmodule
