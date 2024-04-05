module store_unit(
  input [2:0]fun_3,
  input [31:0]iadder_in,
  input [31:0]rs2_in,
  input mem_wr_req,
  output reg [31:0]dm_data_o,
  output [31:0]dm_addr_o,
  output reg [3:0]dm_wr_mask_o,
  output [31:0]dm_wr_req_o
);
  
  assign dm_addr_o = iadder_in;
  assign dm_wr_req_o = mem_wr_req;
  
  always@(*)
    begin 
      case(fun_3)
        2'b00: begin 
          case(iadder_in[1:0])
            2'b01: dm_data_o = {16'b0000_0000,16'b0000_0000,rs2_in[15:8],16'b0000_0000};
            2'b10: dm_data_o = {16'b0000_0000,rs2_in[23:16],16'b0000_0000,16'b0000_0000};
            default: dm_data_o = rs2_in;
          endcase 
        end 
        2'b01: begin 
           dm_data_o = (iadder_in[1])? {rs2_in[31:16],16'b0} : {16'b0,rs2_in[15:0]};
        end 
        default: dm_data_o = rs2_in;
      endcase 
    end 
  
  always@(*)
    begin 
      case(fun_3)
        2'b00: begin 
          case(iadder_in[1:0])
            2'b01: dm_wr_mask_o = {1'b0,1'b0,mem_wr_req,1'b0};
            2'b10: dm_wr_mask_o = {1'b0,mem_wr_req,1'b0,1'b0};
            default: dm_wr_mask_o = {4{mem_wr_req}};
          endcase 
        end 
        2'b01: begin 
           dm_wr_mask_o = (iadder_in[1])? {{2{mem_wr_req}},2'b00} : {2'b00,{2{mem_wr_req}}};
        end 
        default: dm_wr_mask_o = {4{mem_wr_req}};
      endcase 
    end 
endmodule