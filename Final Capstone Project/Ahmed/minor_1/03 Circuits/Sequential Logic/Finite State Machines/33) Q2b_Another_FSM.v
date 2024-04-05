module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output reg f,
    output reg g
); 
    parameter  	A=4'b0000,
    			F1=4'b1100, // state for f =1
    			S1=4'b0001,
    			S2=4'b0010, 
    			S3=4'b0011, 
    			S4=4'b0101, //state for g =1  
    			S5=4'b0110, //state for g =1 permanently
   				S6=4'b0111, //state for y checking
    			S7=4'b1000; //state for g =0 permanently
    reg[3:0] state, next;
    
    // State transition logic;
    always @(*)
        begin
            case(state)
                A : next = resetn ? F1: A;
                F1: next = S1;
                S1: next = x ? S2 : S1; 
                S2: next = x ? S2 : S3;
                S3: next = x ? S4 : S1;
                S4: next = y ? S5 : S6;
                S5: next = ~resetn?A:S5;
                S6: next = y ? S5 : S7;
                S7: next = ~resetn?A:S7;
            endcase
        end
    // State flip-flops 
    always @ (posedge clk)
        begin
            if(~resetn) state <= A;
            else state <= next;
        end
    
    always @ (posedge clk) 
        begin
            case (next)
                F1: f <= 1'b1;
                S6, S4, S5: g <= 1'b1;
                S7: g <= 1'b0;
                default: begin
                    f <= 1'b0;
                    g <= 1'b0;
                end
            endcase
        end

endmodule