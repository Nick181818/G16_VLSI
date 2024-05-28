module PC_MUX(

    input rst_in,
    input branch_taken_in,
    input [1:0] pc_src_in,
    input [31:0] pc_in,
    input [30:0]iaddr_in,
    output [31:0] pc_mux_out,
    output [31:0] pc_plus_4_out,
    output [31:0] i_addr_out
    
);


   wire [31:0] updated_pc_in;
   wire [31:0] updated_iaddr_in;
   wire [31:0] next_pc;
   reg  [31:0] pc_src_out;
  
   assign updated_pc_in = pc_in + 32'h0000_0004;
   assign pc_plus_4_out = updated_pc_in;

  assign updated_iaddr_in = {iaddr_in[30:0],1'b0};

   assign next_pc = (branch_taken_in==1'b0)? updated_pc_in : updated_iaddr_in;
  
  
   always@(*)
     begin 
       case(pc_src_in) 
         2'b00: pc_src_out   = 32'h0000_0000;
         2'b11: pc_src_out   = next_pc;
         default: pc_src_out = next_pc;
       endcase 
     end 
  
   assign pc_mux_out = pc_src_out;
  
   assign i_addr_out = (rst_in == 1'b0)? pc_src_out : 32'h0000_0000;
  
    
endmodule
