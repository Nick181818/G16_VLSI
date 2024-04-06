module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter [1:0] LEFT=2'b00, RIGHT=2'b01, FALL_L=2'b10, FALL_R=2'b11;
    reg [1:0] state, next_state;

    always @(*) begin
        case(state)
            LEFT: next_state = ground ? (bump_left ? RIGHT : LEFT) : FALL_L;
            RIGHT : next_state = ground ? (bump_right ? LEFT : RIGHT) : FALL_R;
            FALL_L : next_state = ground ? LEFT : FALL_L;
            FALL_R : next_state = ground ? RIGHT : FALL_R;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset) state = 0;
        else begin
            state <= next_state;
        end
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state==FALL_L) | (state==FALL_R);

endmodule

