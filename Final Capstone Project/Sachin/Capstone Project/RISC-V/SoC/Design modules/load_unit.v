module load_unit(
    input [31:0] dmdata_in,
    input [1:0] iaddr_out_1_to_0_in,
    input load_unsigned_in,
    input [1:0] load_size_in,
    output [31:0] lu_output_out
);

reg [31:0] lu_output_out_reg;

always @(*) begin
    case (load_size_in)
        2'b00: begin
            if (load_unsigned_in) begin
                case (iaddr_out_1_to_0_in)
                    2'b00: lu_output_out_reg = {24'b0, dmdata_in[7:0]};
                    2'b01: lu_output_out_reg = {16'b0, dmdata_in[15:8], 8'b0};
                    2'b10: lu_output_out_reg = {8'b0, dmdata_in[23:16], 16'b0};
                    2'b11: lu_output_out_reg = {dmdata_in[31:24], 24'b0};
                endcase
            end else begin
                case (iaddr_out_1_to_0_in)
                    2'b00: lu_output_out_reg = {{24{dmdata_in[7]}}, dmdata_in[7:0]};
                    2'b01: lu_output_out_reg = {{16{dmdata_in[15]}}, dmdata_in[15:8], 8'b0};
                    2'b10: lu_output_out_reg = {{8{dmdata_in[23]}}, dmdata_in[23:16], 16'b0};
                    2'b11: lu_output_out_reg = {dmdata_in[31:24], 24'b0};
                endcase
            end
        end
        2'b01: begin
            if (load_unsigned_in) begin
                lu_output_out_reg = {16'b0, dmdata_in[15:0]};
            end else begin
                lu_output_out_reg = {{16{dmdata_in[15]}}, dmdata_in[15:0]};
            end
        end
       
        default: lu_output_out_reg = dmdata_in;
       
    endcase
end

assign lu_output_out = lu_output_out_reg;

endmodule