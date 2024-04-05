`timescale 1ns / 1ps

module Branchunit(
    input [31:0] rs1_in,rs2_in,
    input [4:0] opcode_in6to2,
    input [2:0] func3_in,
    output reg branchtaken_in_net10,
    output reg branchtaken_in_net0,
    output reg branchtaken_in_net1,
    output   branchtaken_out
    );
   wire be,bne,blt,bgte,bltu,bgteu;
   assign be=(rs1_in==rs2_in);
   assign bne=(rs1_in!=rs2_in);
   assign blt=(rs1_in<rs2_in);
   assign bgte=(rs1_in>=rs2_in);
   assign bltu=(rs1_in<rs2_in);
   assign bgteu=(rs1_in>=rs2_in);
   begin 
   always@(func3_in)
   case(func3_in)
   3'b000:branchtaken_in_net10=be;
   3'b001:branchtaken_in_net10=bne;
   3'b100:branchtaken_in_net10=blt;
   3'b101:branchtaken_in_net10=bgte;
   3'b110:branchtaken_in_net10=bltu;
   3'b111:branchtaken_in_net10=bgteu;
    default:branchtaken_in_net10=1'bx;
   endcase
   begin
   always@(opcode_in6to2)
   if (opcode_in6to2==5'b11000)
   branchtaken_in_net0=branchtaken_in_net10;
   else branchtaken_in_net0=0;
  
   end
   begin
   always@(opcode_in6to2)
   if (opcode_in6to2==5'b11011)
   branchtaken_in_net1=1;
   else branchtaken_in_net1=branchtaken_in_net0;

   end
    end
   assign branchtaken_out=branchtaken_in_net1;
  
endmodule