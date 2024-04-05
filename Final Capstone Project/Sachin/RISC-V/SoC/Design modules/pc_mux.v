module pc_mux (
    input rst_in,
    input [1:0] pc_src_in,
    input [31:0] pc_in,
    input branch_taken_in,
    input [30:0] iaddr_in,
    
    output [31:0]   pc_mux_out,
    output [31:0]   pc_plus_4_out,
    output [31:0]   i_addr_out);
    
    
    wire [31:0] PC_plus_4_net   = pc_in + 32'h00000004;
    wire [31:0] imm_addr_net    = {iaddr_in, 1'b0}; 
    
    reg [31:0] next_pc;
    reg [31:0] pc_mux_out_net;

    parameter RESET_STATE       = 2'b00;

    parameter OPERATING_STATE   = 2'b11;

    // MUX Branch Taken
    always @ (*)
    begin
        if (branch_taken_in)
            next_pc = imm_addr_net;
        else
            next_pc = PC_plus_4_net;
    end
    
    // MUX PC Mux Out
    always @ (*)
    begin
        case (pc_src_in)
            RESET_STATE     : pc_mux_out_net = 32'h00000000;
        
            OPERATING_STATE : pc_mux_out_net = next_pc;
            default:           pc_mux_out_net = next_pc;
        endcase
    end
    
    
    // Assignments
    assign pc_plus_4_out        = PC_plus_4_net;
    assign pc_mux_out           = pc_mux_out_net;
    
    assign i_addr_out           = (!rst_in) ? pc_mux_out_net : 32'h00000000;
   
endmodule