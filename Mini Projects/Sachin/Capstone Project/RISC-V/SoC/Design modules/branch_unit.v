module branch_unit (
    input [31:0] rs1_in,
    input [31:0] rs2_in,
    input [4:0] opcode_6_2_in,
    input [2:0] funct3_in,
    output branch_taken_out);

    reg branch_taken_out_net;

    always @(*) begin
        if(opcode_6_2_in==5'b11011 || opcode_6_2_in==5'b11001) //JAL and JALR, Unconditional Jump Instn.
            branch_taken_out_net = 1;
    
        else if(opcode_6_2_in==5'b11000)begin //Branch Instructions
            case(funct3_in)
                3'b000: branch_taken_out_net = (rs1_in==rs2_in) ? 1 : 0; //BEQ
                3'b001: branch_taken_out_net = (rs1_in!=rs2_in) ? 1 : 0; //BNE
                3'b010: branch_taken_out_net = 0;
                3'b011: branch_taken_out_net = 0;
                3'b100: branch_taken_out_net = (rs1_in < rs2_in) ? 1 : 0; //BLT
                3'b101: branch_taken_out_net = (rs1_in > rs2_in) ? 1 : 0; //BGE
                3'b110: branch_taken_out_net = $signed(rs1_in) < $signed(rs2_in) ? 1 : 0; //Signed BLT //MSB=1
                3'b111: branch_taken_out_net = $signed(rs1_in) > $signed(rs2_in) ? 1 : 0;
                default: branch_taken_out_net = 0;
            endcase
        end
        else branch_taken_out_net = 1'b0;
    end

    assign branch_taken_out = branch_taken_out_net;
endmodule
