`timescale 1ns / 1ps



module pcunit(
input rst_in,input [1:0] pc_src_in,
input [31:0]pc_in, input branch_taken_in,
 input [31:0]iaddr_in,output reg [31:0]pc_mux_out,
  wire [31:0]pc_plus4_out,output reg [31:0]next_pc, output reg[31:0] iaddr_out
    );
     
    begin
    always@(branch_taken_in)
   case(branch_taken_in)
   1'b0:next_pc=pc_in+32'h0000_0004;
   1'b1:next_pc={{iaddr_in[31:1]},1'b0};
   endcase 
   always@(pc_src_in)
   case(pc_src_in)
   2'b00:pc_mux_out=32'h0000_0000;
   2'b11:pc_mux_out=next_pc;
   endcase
   always@(rst_in)
   if(rst_in)
   iaddr_out=32'b0;
   else iaddr_out=pc_mux_out;
   
    end
    assign pc_plus4_out=pc_in+32'h0000_0004;
endmodule
