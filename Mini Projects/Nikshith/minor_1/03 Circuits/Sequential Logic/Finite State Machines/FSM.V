module top_module(
    input clk,
    input areset,
    input in,
    output out);

    parameter A=0, B=1;
    reg state, next_state;

    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;
        end
        else begin
            state <= next_state;
        end
    end

    assign out = (state == B);

endmodule
