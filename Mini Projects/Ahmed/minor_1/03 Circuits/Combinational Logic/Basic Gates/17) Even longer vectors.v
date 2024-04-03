module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );
    
	integer i;
    assign out_both[0] = (in[1] & in[0]) ? 1'b1:1'b0;
    assign out_different[0] = (in[0] ^ in[1]) ? 1'b1:1'b0;
    
    always @ (in) begin
    for(i=1; i<99; i=i+1) begin
        out_both[i] = (in[i] & in[i+1]) ? 1'b1:1'b0;
        out_any[i] = (in[i] | in[i-1]) ? 1'b1:1'b0;
        out_different[i] = (in[i] ^ in[i+1]) ? 1'b1:1'b0; 
    end
    end
    
    assign out_any[99] = (in[99] | in[98]) ? 1'b1:1'b0;
    assign out_different[99] = (in[99] ^ in[0]) ? 1'b1:1'b0;
    
endmodule