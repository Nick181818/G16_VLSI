module branch_unit(
    input [31:0] rs1_in,
    input [31:0] rs2_in,
    input [4:0] opcode_6_2_in,
    input [2:0] fun_3_in,
    output reg branch_taken_o
);

always @* begin
    case (opcode_6_2_in)
        5'b1100: branch_taken_o = 1'b1; // Unconditional branch
        5'b11000: begin // Conditional branch
            case (fun_3_in)
                3'b000: branch_taken_o = (rs1_in == rs2_in) ? 1'b1 : 1'b0; 
                3'b001: branch_taken_o = (rs1_in != rs2_in) ? 1'b1 : 1'b0; 
                3'b100: branch_taken_o = ($signed(rs1_in) < $signed(rs2_in)) ? 1'b1 : 1'b0; 
                3'b101: branch_taken_o = ($signed(rs1_in) >= $signed(rs2_in)) ? 1'b1 : 1'b0; 
                3'b110: branch_taken_o = ($signed(rs1_in) < $signed(rs2_in)) ? 1'b1 : 1'b0; 
                3'b111: branch_taken_o = ($signed(rs1_in) >= $signed(rs2_in)) ? 1'b1 : 1'b0; 
                default: branch_taken_o = 1'b0; 
            endcase
        end
        default: branch_taken_o = 1'b0; 
    endcase
end

endmodule
