module top_module (
    input clk,
    input reset,   
    input j,
    input k,
    output out
);
    // Define state values
    parameter OFF = 0, ON = 1; 
    // State and next state registers
    reg state, next_state;
    // State transition logic
    always @* begin
        case (state)
            OFF: next_state = (j) ? ON : OFF;
            ON: next_state = (k) ? OFF : ON;
        endcase
    end
    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state<=next_state;
        end
    end
    // Output logic
    assign out = (state == ON);
endmodule
