module ctrl_unit (
    input clk_in,                   // Clock signal
    input rst_in,                   // Reset Interrupt
    output reg flush_out,           // Flush signal to reset
    output reg [1:0] pc_src_out
);
    parameter RESET = 0, // Processor reset state 
              OPRTG = 1; // Processor operating state
    reg state, next;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        case (state)
            RESET : next = OPRTG;
            OPRTG : next = OPRTG;
        endcase
    end

    always @(posedge clk_in) // This is a sequential always block
    begin    
        // State flip-flops with synchronous reset
        if(rst_in) state <= RESET;
        else state <= next;
    end

    // Output logic
    always @(*)
    begin
    if (state == RESET) 
        begin
            flush_out = 1'b1;
            pc_src_out = 2'b00;
        end 
    else 
        begin
            flush_out = 1'b0;
            pc_src_out = 2'b11;
        end
    end
    
endmodule