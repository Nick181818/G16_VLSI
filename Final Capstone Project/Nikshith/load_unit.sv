module load_unit(
    input [31:0] dm_data_in,
    input [1:0] iadder_out_1to0_in,
    input load_unsigned_in,
    input [1:0] load_size_in,
    output reg [31:0] load_output_o
);

always @* begin
    case (load_size_in)
        2'b00: begin // Byte
            case (iadder_out_1to0_in)
                2'b00: load_output_o = load_unsigned_in ? {{24{1'b0}}, dm_data_in[7:0]} : {{24{dm_data_in[7]}}, dm_data_in[7:0]};
                2'b01: load_output_o = load_unsigned_in ? {{16{1'b0}}, dm_data_in[15:8], {8{1'b0}}} : {{16{dm_data_in[15]}}, dm_data_in[15:8], {8{dm_data_in[15]}}};
                2'b10: load_output_o = load_unsigned_in ? {{8{1'b0}}, dm_data_in[23:16], {16{1'b0}}} : {{8{dm_data_in[23]}}, dm_data_in[23:16], {16{dm_data_in[23]}}};
                2'b11: load_output_o = load_unsigned_in ? {dm_data_in[31:24], {24{1'b0}}} : {dm_data_in[31:24], {24{dm_data_in[31]}}};
            endcase
        end
        2'b01: begin // Halfword
            case (iadder_out_1to0_in[1])
                1'b0: load_output_o = load_unsigned_in ? {{16{1'b0}}, dm_data_in[15:0]} : {{16{dm_data_in[15]}}, dm_data_in[15:0]};
                1'b1: load_output_o = {dm_data_in[15:0], {16{1'b0}}};
            endcase
        end
        default: load_output_o = dm_data_in; // Word
    endcase
end

endmodule
