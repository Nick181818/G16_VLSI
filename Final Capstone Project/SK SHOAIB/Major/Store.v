module store_unit(
  
  input mem_wr_req,
  input [1:0] func3,
  input [31:0] iadder_in,
  input [31:0] rs2_in,
  output [31:0] dm_addr_out,
  output  dm_wr_req_out,
  output reg [3:0] dm_wr_mask_out,
  output reg [31:0] dm_data_out

);
  
  assign dm_addr_out   = iadder_in;
  assign dm_wr_req_out = mem_wr_req;
  
  always@(*)
    begin 
      case(func3)
        2'b00: begin 
          case(iadder_in[1:0])
            2'b01: dm_data_out   = {8'b0,8'b0,rs2_in[15:8],8'b0};
            2'b10: dm_data_out   = {8'b0,rs2_in[23:16],8'b0,8'b0};
            default: dm_data_out = rs2_in;
          endcase 
        end 
        2'b01: begin 
          assign dm_data_out = (iadder_in[1])? {rs2_in[31:16],16'b0} : {16'b0,rs2_in[15:0]};
        end 
        default: dm_data_out = rs2_in;
      endcase 
    end 
  
  always@(*)
    begin 
      case(func3)
        2'b00: begin 
          case(iadder_in[1:0])
            2'b01: dm_wr_mask_out   = {1'b0,1'b0,mem_wr_req,1'b0};
            2'b10: dm_wr_mask_out   = {1'b0,mem_wr_req,1'b0,1'b0};
            default: dm_wr_mask_out = {4{mem_wr_req}};
          endcase 
        end 
        2'b01: begin 
          assign dm_wr_mask_out = (iadder_in[1])? {{2{mem_wr_req}},2'b00} : {2'b00,{2{mem_wr_req}}};
        end 
        default: dm_wr_mask_out = {4{mem_wr_req}};
      endcase 
    end 
  
endmodule 
  
        
