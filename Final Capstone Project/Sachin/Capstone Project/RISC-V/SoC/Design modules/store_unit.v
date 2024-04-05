module store_unit(
    input mem_wr_req,
    input [2:0] func3,
    input [31:0] iadder_in,
    input [31:0] rs2_in,
    output [3:0] dmwr_mask_out,
    output [31:0] dmdata_out,
    output [31:0] dmaddr_out,
    output dmwr_req_out);

assign dmaddr_out = iadder_in;
assign dmwr_req_out = mem_wr_req;

assign dmdata_out = (func3 == 3'b000) ? ((iadder_in[1:0] == 2'b00) ? rs2_in :
                                          (iadder_in[1:0] == 2'b01) ? {8'b0, 8'b0, rs2_in[15:8], 8'b0} :
                                          (iadder_in[1:0] == 2'b10) ? {8'b0, rs2_in[23:16], 8'b0, 8'b0} :
                                          {rs2_in[31:24], 24'b0}) :
                      (func3 == 3'b001) ? ((iadder_in[1]) ? {rs2_in[31:16], 16'b0} : {16'b0, rs2_in[15:0]}) :
                      rs2_in;

assign dmwr_mask_out = (func3 == 3'b000) ? ((iadder_in[1:0] == 2'b00) ? 4'b1111 :
                                             (iadder_in[1:0] == 2'b01) ? 4'b0011 :
                                             (iadder_in[1:0] == 2'b10) ? 4'b1100 :
                                             4'b0000) :
                        (func3 == 3'b001) ? ((iadder_in[1]) ? 4'b1100 : 4'b0011) :
                        4'b1111;

endmodule