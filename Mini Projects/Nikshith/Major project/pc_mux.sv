module PC_MUX(
    input rst_in,
    input [1:0] pc_src_in,
    input [31:0] pc_in,
    input [31:0] iaddr_in,
    input branch_taken_in,
    output reg [31:0] pc_mux_o,
    output reg [31:0] pc_plus_4_o,
    output reg [31:0] iaddr_o
);

always @(*) begin
    case(pc_src_in)
        2'b00: pc_mux_o = rst_in ? 32'h0000_0013 : iaddr_in;
        default: pc_mux_o = branch_taken_in ? {iaddr_in, 1'b0} : pc_in + 32'h0000_0004;
    endcase
end

always @(*) begin
    pc_plus_4_o = pc_in + 32'h0000_0004;
    iaddr_o = rst_in ? 32'h0000_0000 : pc_mux_o;
end

endmodule