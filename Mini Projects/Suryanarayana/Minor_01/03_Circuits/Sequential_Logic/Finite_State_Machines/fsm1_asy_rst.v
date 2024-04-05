module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);  
    parameter A=1'd0, B=1'd1; 
    reg state, next_state;
    always @(*) begin    
        case(state)
            A: next_state = in ? A:B;
            B: next_state = in ? B:A;
            default: next_state = next_state;
        endcase
    end
    always @(posedge clk, posedge areset) begin    
        if(areset)
            state<=B;
        else
            state<=next_state;
    end
    // Output logic
    assign out = (state == B);
endmodule
