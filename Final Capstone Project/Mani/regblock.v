`timescale 1ns / 1ps

module reg_block(
    input [31:0] pc_mux_in,
    input rst_in,clk_in,
    output reg [31:0] pc_out
    );
    begin
    always@(posedge clk_in)
    if (rst_in)
    pc_out=0;
    else pc_out=pc_mux_in;
end
endmodule
