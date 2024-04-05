module control_unit(
    input clk_in,
    input rst_in,
    output flush_out,
    output [1:0] pc_src_out
);

reg [1:0] present_state, next_state;
reg [1:0] pc_src_out_reg;
reg flush_out_net;

// State machine logic
parameter RESET = 2'b00;
parameter operating = 2'b01;

always @(*) begin
    case(present_state)
        RESET: next_state = RESET;
        operating: next_state = (RESET[0]) ? (RESET) : operating;  // Fixed Warning-WIDTH
        default: next_state = operating;
    endcase
end

always @(posedge clk_in or posedge rst_in) begin
    if(rst_in) begin
        present_state <= RESET;
    end else begin
        present_state <= next_state;
    end
end

always @(*) begin
    case(present_state)
        RESET: begin
            pc_src_out_reg = 2'b00;
            flush_out_net = 1;
        end
        operating: begin
            pc_src_out_reg = 2'b11;
            flush_out_net = 0;
        end
        default: begin  // Added default case to fix Warning-CASEINCOMPLETE
            pc_src_out_reg = 2'b00;
            flush_out_net = 0;
        end
    endcase
end

assign pc_src_out = pc_src_out_reg;
assign flush_out = flush_out_net;

endmodule