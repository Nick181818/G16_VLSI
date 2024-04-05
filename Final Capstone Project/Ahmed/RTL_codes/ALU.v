module ALU (
    input [31:0] op_1_in,           // Operand 1
    input [31:0] op_2_in,           // Operand 1
    input [3:0] opcode_in,          // Opcode for Deciding ALU Operation
    output reg [31:0] result_out    // Result of Operation
);

    always @ (*)
    begin
        if (opcode_in == 4'b0000) begin
            result_out = op_1_in + op_2_in;     //Addition                   
        end 
        else if (opcode_in == 4'b1000) begin
            result_out = op_1_in - op_2_in;     // Subtraction                 
        end 
        else if (opcode_in == 4'b0010) begin
            result_out = (op_1_in < op_2_in)?1:0;  // Set Less Than                       
        end
        else if (opcode_in == 4'b0011) begin
            result_out = (op_1_in < op_2_in)?1:0;  // Set Less Than Unsigned                      
        end
        else if (opcode_in == 4'b0111) begin
            result_out = op_1_in & op_2_in;   // Bitwise AND                    
        end
        else if (opcode_in == 4'b0110) begin
            result_out = op_1_in | op_2_in;   // Bitwise OR                    
        end
        else if (opcode_in == 4'b0100) begin
            result_out = op_1_in ^ op_2_in;   // Bitwise XOR                      
        end
        else if (opcode_in == 4'b0001) begin
            result_out = op_1_in << op_2_in;  // Logical Left Shift                      
        end
        else if (opcode_in == 4'b0101) begin
            result_out = op_1_in >> op_2_in;  // Logical Right Shift                
        end
        else if (opcode_in == 4'b1101) begin
            result_out = op_1_in >>> op_2_in; // Arithematic Right Shift                        
        end
        else begin
            result_out = op_1_in + op_2_in;     // Default                  
        end 
    end
    
endmodule