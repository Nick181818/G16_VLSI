
module immediate_generator(
    input   [31:7]    inst_in,
    input   [2:0]     imm_type_in,
    output  [31:0]    imm_out
);

    // Declaring Nets
    reg [31:0] i_type, s_type, b_type, u_type, j_type;
    
  	reg [31:0] imm_gen;
    
    always @ (*)
    begin
        i_type   = {{20{inst_in[31]}}, inst_in[31:20]};
        s_type   = {{20{inst_in[31]}}, inst_in[31:25], inst_in[11:7]};
        b_type   = {{20{inst_in[31]}}, inst_in[7], inst_in[30:25], inst_in[11:8], 1'b0};
        u_type   = {inst_in[31:12], 12'h000};
        j_type   = {{12{inst_in[31]}}, inst_in[19:12], inst_in[20], inst_in[30:21], 1'b0};
    end
    
    always @ (*)
    begin
        case(imm_type_in)
            3'b000: imm_gen = 32'h00000000;
            3'b001: imm_gen = i_type;
            3'b010: imm_gen = s_type;
            3'b011: imm_gen = b_type;
            3'b100: imm_gen = u_type;
            3'b101: imm_gen = j_type;
            3'b111: imm_gen = i_type;
            default imm_gen = i_type;
        endcase
    end
    
    assign imm_out[31:0] = imm_gen[31:0];
endmodule
