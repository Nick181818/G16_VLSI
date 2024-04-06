module alu_unit(
    input [3:0] opcode_in,
    input signed[31:0] op_1_in,
    input signed[31:0] op_2_in,
    output signed[31:0] alu_result
); 
    
    // Declaring reg net for storinf result in procedural block
  reg signed [31:0] alu_data_out;
    
    always @ (*)
    begin
        case (opcode_in)
            4'b0000: alu_data_out = op_1_in + op_2_in;
            4'b1000: alu_data_out = op_1_in - op_2_in;
            4'b0010: alu_data_out = (op_1_in < op_2_in) ? 32'hffff_ffff:0;
            4'b0011: alu_data_out = ($unsigned(op_1_in) < $unsigned(op_2_in)) ? 32'hffff_ffff:0;
            4'b0111: alu_data_out = op_1_in & op_2_in;
            4'b0110: alu_data_out = op_1_in | op_2_in;
            4'b0100: alu_data_out = op_1_in ^ op_2_in;
            4'b0001: alu_data_out = op_1_in << op_2_in; 
            4'b0101: alu_data_out = op_1_in >> op_2_in;
            4'b1101: alu_data_out = op_1_in >>> op_2_in;
            default: alu_data_out = 32'b0;
        endcase
    end
    
    assign alu_result = alu_data_out;
    
endmodule
