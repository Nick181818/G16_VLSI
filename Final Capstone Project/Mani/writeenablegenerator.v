`timescale 1ns / 1ps

module writeenablegenerator(input clk,
    input flush_in,
    input wr_en_reg_in,
    output reg wr_en_reg_file_out
    );
    always@(posedge clk)
    begin
    if(flush_in==0)
    wr_en_reg_file_out=wr_en_reg_in;
    else wr_en_reg_file_out=0;
    end
    
endmodule