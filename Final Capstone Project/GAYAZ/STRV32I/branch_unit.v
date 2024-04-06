module branch_unit(
    input signed [31:0] rs1_in,
    input [4:0] opcode_6_to_2_in,
    input [2:0] func3_in,
    input signed [31:0] rs2_in,
    output branch_taken_out
    );
    
    
    reg branch_out;
    
    always @(*)
    begin
      if ((opcode_6_to_2_in == 5'b11011) || (opcode_6_to_2_in == 5'b11001))   
        begin
            branch_out = 1'b1;
        end
        else if (opcode_6_to_2_in == 5'b11000) 
        begin
            case (func3_in)
                3'b000: branch_out = (rs1_in == rs2_in) ? 1'b1 : 1'b0;
                3'b001: branch_out = (rs1_in != rs2_in) ? 1'b1 : 1'b0;
                3'b010: branch_out = 1'b0;
                3'b011: branch_out = 1'b0;
                3'b100: branch_out = (rs1_in < rs2_in) ? 1'b1 : 1'b0;
                3'b101: branch_out = (rs1_in >= rs2_in) ? 1'b1 : 1'b0;
                3'b110: branch_out = $unsigned(rs1_in)<$unsigned(rs2_in);
                3'b111: branch_out = $unsigned(rs1_in) >= $unsigned(rs2_in) ;
                default branch_out = 1'b0;
            endcase
        end
        else
        begin
            branch_out = 1'b0;
        end    
    end 
    
    assign branch_taken_out = branch_out;
endmodule
