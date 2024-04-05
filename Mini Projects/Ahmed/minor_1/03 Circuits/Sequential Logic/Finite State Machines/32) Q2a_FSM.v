module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    reg [1:0] state , next_state;
    // State transition logic
    always @(*)begin
        case(state)
            A: begin 
                if (r[1]==1) next_state = B;
                else if (~r[1]&r[2]==1) next_state = C;
                else if (~r[1]&~r[2]&r[3]==1) next_state = D;
                else next_state = A;
            end
            B: next_state = r[1] ? B:A;
            C: next_state = r[2] ? C:A;
            D: next_state = r[3] ? D:A;
        endcase
    end
    // State flip-flops with asynchronous reset
    always @(posedge clk)begin
        if(~resetn) state <= A;
        else state <= next_state;
    end
    // Output logic
    assign  g[3] = (state == D);
    assign  g[2] = (state == C);
    assign  g[1] = (state == B);
    
endmodule
