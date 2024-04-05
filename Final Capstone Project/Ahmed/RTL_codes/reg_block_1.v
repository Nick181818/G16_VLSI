//
// Reg Block 1
//
module reg_block_1 (
    input [31:0] pc_mux_in,     // Program Counter Value
    input rst_in,               // Reset Signal
    input clk_in,               // Clock Signal
    output reg [31:0] pc_out    // Delayed Program Counter Value
);

    always @(posedge clk_in)
    begin
        if (rst_in) begin
            pc_out <= 32'h0;
        end
        else 
            pc_out <= pc_mux_in;
    end 
    
endmodule