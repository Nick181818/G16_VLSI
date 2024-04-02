module reg_block_1(
    input clk_in,
    input rst_in,
    input [31:0] pc_mux_in,
    output [31:0] pc_mux_out
    );
    
    reg  mux_out;

    always @ (posedge clk_in or posedge rst_in)
    begin
     if(rst_in)
        mux_out <= 32'b00;
     else
        mux_out <= pc_mux_in;
    end

    assign pc_mux_out = mux_out;

endmodule