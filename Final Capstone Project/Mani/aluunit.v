`timescale 1ns / 1ps

module ALUunit(
    input [31:0] op1_in,op2_in,
    input [3:0] opcode_in,
    output reg[31:0]result_out,
    output ALU_add,ALU_SLL,ALU_setlessthan,
    output ALU_setlessthanu,ALU_XOR,
    output ALU_SRL,ALU_OR,ALU_AND,
    output ALU_sub,ALU_SRA
    );
    begin
    always@(opcode_in)
    if(opcode_in==4'b0000)
    result_out=ALU_add;
    else if(opcode_in==4'b0001)
    result_out=ALU_SLL; //Logical left shift
    else if(opcode_in==4'b0010)
    result_out=ALU_setlessthan;
    else if(opcode_in==4'b0011)
    result_out=ALU_setlessthanu;
    else if(opcode_in==4'b0100)
    result_out=ALU_XOR;   //Bitwise XOR
    else if(opcode_in==4'b0101)
    result_out=ALU_SRL; //Logical right shift
    else if(opcode_in==4'b0110)
    result_out=ALU_OR; //Bitwise OR
    else if(opcode_in==4'b0111)
    result_out=ALU_AND;  //Bitwise AND
    else if(opcode_in==4'b1000)
    result_out=ALU_sub;
    else if(opcode_in==4'b1101)
    result_out=ALU_SRA;  //Arithmetic right shift
    else result_out=1'bz;
    
    end
assign ALU_add=op1_in+op2_in;
assign ALU_SLL=op1_in<<op2_in;
assign ALU_setlessthan=op1_in<op2_in;
assign ALU_setlessthanu=op1_in<op2_in;
assign ALU_SRA=op1_in>>>op2_in;
assign ALU_sub=op1_in-op2_in;
assign ALU_AND=op1_in&op2_in;
assign ALU_OR=op1_in|op2_in;
assign ALU_XOR=op1_in^op2_in;
assign ALU_SRL=op1_in>>op2_in;
endmodule