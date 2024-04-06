module ALU_block(
    input [31:0] op_1_in,
    input [31:0] op_2_in,
    input [2:0] opcode_in,
    output reg [31:0] result_o
);

always @* begin
    case (opcode_in)
        4'b0000: result_o = op_1_in + op_2_in; // Addition
        4'b0001: result_o = op_1_in << op_2_in; // Shift Left Logical
        4'b0010: result_o = (op_1_in < op_2_in) ? 32'b1 : 32'b0; // Set if Less Than (signed)
        4'b0011: result_o = (op_1_in < op_2_in) ? 32'b1 : 32'b0; // Set if Less Than (unsigned)
        4'b0100: result_o = op_1_in ^ op_2_in; // Bitwise XOR
        4'b0101: result_o = op_1_in >> op_2_in; // Shift Right Arithmetic
        4'b0110: result_o = op_1_in | op_2_in; // Bitwise OR
        4'b0111: result_o = op_1_in & op_2_in; // Bitwise AND
        4'b1000: result_o = op_1_in - op_2_in; // Subtraction
        4'b1101: result_o = op_1_in >>> op_2_in; // Shift Right Logical
        default : result_o = 32'b0; // Default case
    endcase
end

endmodule
