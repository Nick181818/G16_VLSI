module immediate_adder(
    input [31:0] pc_in,
    input [31:0] rs1_in,
    input [31:0] imm_in,
    input iaddr_src,
    output reg [31:0] iaddr_out);

    // net wire
    wire [31:0] mux1_out;

    assign mux1_out = (iaddr_src) ? rs1_in : pc_in;

    always @(*) begin
        iaddr_out = mux1_out + imm_in;
    end

endmodule
