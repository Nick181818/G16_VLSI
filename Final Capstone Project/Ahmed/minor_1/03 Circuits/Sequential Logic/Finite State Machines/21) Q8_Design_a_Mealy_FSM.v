module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    parameter [1:0] S1=00, S2=01, S3=10;
    reg [1:0] state, next_state;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        case (state)
            S1: next_state = x ? S2:S1;
            S2: next_state = x ? S2:S3;
            S3: next_state = x ? S2:S1;
            default: next_state = S1;
        endcase
    end

    always @(posedge clk or negedge aresetn) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if(!aresetn) state <= S1;
        else state <= next_state;
    end

    // Output logic
            assign z = (state == S3)&x;

endmodule