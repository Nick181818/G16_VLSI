module load_unit(
  
  input [31:0] dm_data_in,
  input [1:0] iadder_out_1_to_0_in,
  input load_unsigned_in,
  input [1:0] load_size_in,
  output reg [31:0] load_output_out
  
);
  
  
  always@(*)
    begin 
      case(load_size_in)
        2'b00: begin 
          case(iadder_out_1_to_0_in)
            2'b00: load_output_out = (load_unsigned_in)? {24'b0,dm_data_in[7:0]}        : {{24{dm_data_in[7]}},dm_data_in[7:0]};
            2'b01: load_output_out = (load_unsigned_in)? {16'b0,dm_data_in[15:8],8'b0}  : {{16{dm_data_in[7]}},dm_data_in[15:8],8'b0};
            2'b10: load_output_out = (load_unsigned_in)? {8'b0,dm_data_in[23:16],16'b0} : {{8{dm_data_in[7]}},dm_data_in[23:16],16'b0};
            2'b11: load_output_out = (load_unsigned_in)? {dm_data_in[31:24],24'b0}      : {dm_data_in[31:24],24'b0}; 
          endcase 
        end 
        2'b01: begin 
          case(iadder_out_1_to_0_in[1])
            1'b0: load_output_out = (load_unsigned_in)? {16'b0,dm_data_in[15:0]}  : {{16{dm_data_in[15]}},dm_data_in[15:0]}; 
            1'b1: load_output_out = (load_unsigned_in)? {dm_data_in[31:16],16'b0} : {dm_data_in[31:16],16'b0}; 
          endcase 
        end 
        default: load_output_out = dm_data_in; 
      endcase 
    end 
  
endmodule
