module branch_unit(
  
  input [31:0] rs1_in,          // Content of Source Register 1
  input [31:0] rs2_in,          // Content of Source Register 1
  input [4:0] opcode_6_2_in,    // Opcode Deciding Branch or Jump Operation
  input [2:0] func3_in,         // Opcode Deciding type of Branch Operation
  output reg branch_taken_out   // Branch taken or not

); 
  
  wire equal;
  wire not_equal;
  wire less_than;
  wire greater_than_equal_to;
  wire less_than_unsigned;
  wire greater_than_equal_to_unsigned;
  
  assign equal                          = (rs1_in == rs2_in)? 1'b1 : 1'b0;
  assign not_equal                      = (rs1_in != rs2_in)? 1'b1 : 1'b0;
  assign less_than                      = (rs1_in < rs2_in)? 1'b1 : 1'b0;
  assign greater_than_equal_to          = (rs1_in >= rs2_in)? 1'b1 : 1'b0;
  assign less_than_unsigned             = (rs1_in < rs2_in)? 1'b1 : 1'b0;
  assign greater_than_equal_to_unsigned = (rs1_in >= rs2_in)? 1'b1 : 1'b0;
  
  always@(*)
    begin 
      case(opcode_6_2_in)
        5'b11011: branch_taken_out =1'b1;
        5'b11001: branch_taken_out =1'b1;
        5'b11000: begin 
          case(func3_in)
            3'b000: branch_taken_out  = equal;
            3'b001: branch_taken_out  = not_equal;
            3'b100: branch_taken_out  = less_than;
            3'b101: branch_taken_out  = greater_than_equal_to;
            3'b110: branch_taken_out  = less_than_unsigned;
            3'b111: branch_taken_out  = greater_than_equal_to_unsigned;
            default: branch_taken_out = 1'b0;
          endcase
        end 
        default: branch_taken_out = 1'b0;
      endcase 
    end 
  
endmodule