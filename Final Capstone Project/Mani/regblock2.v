`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2024 20:54:58
// Design Name: 
// Module Name: Reg_block2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Reg_block2(
    input rst_in,clk_in,
    input [4:0] rd_addr_in,
    input [31:0] rs1_in,rs2_in,
    input [31:0]pc_in,pc_plus_4_in,
    input [31:0] iadder_in,
    input branchtaken_in,
    input [3:0]aluopcode_in,
    input [1:0]load_size_in,
    input load_unsigned_in,
    input alu_src_in,
    input [2:0]wb_mux_sel_in,
    input immd_in,rf_wr_en,
    output reg [4:0]rd_addr_reg_out,
    output reg [31:0]rs1_reg_out,output reg [31:0] rs2_reg_out, output reg[31:0] pc_reg_out,
 output  reg [31:0]pc_plus_4_reg_out,output reg [31:0]iadder_reg_out,
    output reg [3:0]aluopcode_reg_out,
    output  reg [1:0]load_size_reg_out,
    output  reg load_unsigned_reg_out,
    output reg  alu_src_reg_out,
    output  reg [2:0]wb_mux_sel_reg_out,
    output reg immd_reg_out,output reg rf_wr_en_reg
    
    );
    
    always@(posedge clk_in)
    begin
    if(rst_in)
    begin
    rd_addr_reg_out=5'b0;
    rs1_reg_out=32'b0;
    rs2_reg_out=32'b0;
    pc_reg_out=32'b0;
    pc_plus_4_reg_out=32'b0;
    iadder_reg_out=32'b0;
    aluopcode_reg_out=4'b0;
    load_size_reg_out=2'b0;
    load_unsigned_reg_out=0;
    alu_src_reg_out=0;
    wb_mux_sel_reg_out=3'b0;
    immd_reg_out=0;
    rf_wr_en_reg=0;
   end
   else
  
   rd_addr_reg_out=rd_addr_in;
   rs1_reg_out=rs1_in;
   rs2_reg_out=rs2_in;
   pc_reg_out=pc_in;
   pc_plus_4_reg_out=pc_plus_4_in;
   iadder_reg_out=(iadder_in&(~branchtaken_in))|({{iadder_in[31:1]},1'b0}&branchtaken_in);
   aluopcode_reg_out=aluopcode_in;
   load_size_reg_out=load_size_in;
  load_unsigned_reg_out=load_unsigned_in;
  alu_src_reg_out=alu_src_in;
  wb_mux_sel_reg_out=wb_mux_sel_in;
  immd_reg_out=immd_in;
  rf_wr_en_reg=rf_wr_en;
  end
endmodule
