//
// Immediate Adder Block
//
module imm_adder (
    input iadder_src,
    input [31:0] pc_in,         // Program counter value
    input [31:0] rs1_in,        // Content of Source register
    input [31:0] imm_in,        // Immediate data
    output [31:0] iadder_out    // Added Result
);

wire [31:0] temp_adder; // carries the selected data from pc_in and rs1_in

assign temp_adder = iadder_src ? rs1_in : pc_in;

assign iadder_out = temp_adder + imm_in;
    
endmodule