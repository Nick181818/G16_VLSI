module immediate_generator (
    input [31:7] instr_in,
    input [2:0] imm_type_in,
    output [31:0] imm_out
);

// Intermediate registers
reg [31:0] R, I, S, B, U, J;
reg [31:0] imm_out_reg;

always @(*) begin
    R = 32'h0;

    I = {{20{instr_in[31]}}, instr_in[31:20]};
    S = {{20{instr_in[31]}}, instr_in[31:25], instr_in[11:7]};

    B = {{20{instr_in[31]}}, instr_in[7], instr_in[30:25], instr_in[11:8], 1'b0};
    U = {instr_in[31:12], 12'h0};
    J = {{12{instr_in[31]}}, instr_in[19:12], instr_in[20], instr_in[30:21], 1'b0};
end

always @ (*)

    begin

        case(imm_type_in)

            3'b000: imm_out_reg = R;

            3'b001: imm_out_reg = I;

            3'b010: imm_out_reg = S;

            3'b011: imm_out_reg = B;

            3'b100: imm_out_reg = U;

            3'b101: imm_out_reg = J;

            3'b111: imm_out_reg = I;

            default imm_out_reg = I;

        endcase

    end

assign imm_out[31:0] = imm_out_reg[31:0];

endmodule