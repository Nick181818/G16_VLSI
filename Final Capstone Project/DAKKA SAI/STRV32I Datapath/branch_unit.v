module branch_unit(
  input [31:0]rs1_in,
  input [31:0]rs2_in,
  input [4:0]opcode_6_2_in,
  input [2:0]fun_3_in,
  output branch_taken_o
);
    reg branch_taken_o_net1;

    always @(*) 
    begin
      if(opcode_6_2_in==5'b1100)
            branch_taken_o_net1 = 1;
    
        else if(opcode_6_2_in==5'b11000)
        begin 
          case(fun_3_in)
                3'b000: branch_taken_o_net1 = (rs1_in==rs2_in) ? 1 : 0; 
                3'b001: branch_taken_o_net1 = (rs1_in!=rs2_in) ? 1 : 0; 
                3'b010: branch_taken_o_net1 = 0;
                3'b011: branch_taken_o_net1 = 0;
                3'b100: branch_taken_o_net1 = (rs1_in < rs2_in) ? 1 : 0; 
                3'b101: branch_taken_o_net1 = (rs1_in >= rs2_in) ? 1 : 0; 
                3'b110: branch_taken_o_net1 = $signed(rs1_in) < $signed(rs2_in) ? 1 : 0;
                3'b111: branch_taken_o_net1 = $signed(rs1_in) >= $signed(rs2_in) ? 1 : 0;
                default: branch_taken_o_net1 = 0;
            endcase
        end
        else branch_taken_o_net1 = 1'b0;
    end

    assign branch_taken_o = branch_taken_o_net1;
endmodule