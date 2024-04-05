`timescale 1ns / 1ps

module immediate_adder(input [31:0]pc_in,
input [31:0]rs1_in, input[31:0] immd_in,
input i_adder_src,output reg [31:0]i_adder_out
    );
    begin
    always@(i_adder_src)
    if(i_adder_src) 
     i_adder_out=pc_in+immd_in;
     else
     i_adder_out=rs1_in+immd_in;
     end
endmodule
