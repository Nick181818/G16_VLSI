module immediate_adder(
    input [31:0] imm_in,
    input iaddr_src_in,
    input [31:0] pc_in,
    input [31:0] rs1_in,
    
    output [31:0] iaddr_out
    );
    
    // Declaring intermediate net
  wire [31:0] imadd;
    
    // Mux
    assign imadd = (iaddr_src_in) ? rs1_in : pc_in;
    
    //Adder module
    assign iaddr_out[31:0] = imadd[31:0] + imm_in[31:0];
    
endmodule
