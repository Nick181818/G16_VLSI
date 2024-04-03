module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    parameter [3:0] S0=0, S1=1,S2=2, S3=3,S4=4, S5=5,S6=6, ERR=7,DISC=8, FLAG=9; 
    reg [3:0] state, next_state;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        case (state)
            S0 : next_state = in ? S1 : S0;
            S1 : next_state = in ? S2 : S0;
            S2 : next_state = in ? S3 : S0;
            S3 : next_state = in ? S4 : S0;
            S4 : next_state = in ? S5 : S0;
            S5 : next_state = in ? S6 : DISC;
            S6 : next_state = in ? ERR : FLAG;
            ERR : next_state = in ? ERR : S0;
            DISC : next_state = in ? S1 : S0;
            FLAG : next_state = in ? S1 : S0;
        endcase
    end

    always @(posedge clk) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if(reset) state <= S0;
        else state <= next_state;
    end

    // Output logic
    assign disc = (state == DISC);
    assign flag = (state == FLAG);
    assign err = (state == ERR);


endmodule

