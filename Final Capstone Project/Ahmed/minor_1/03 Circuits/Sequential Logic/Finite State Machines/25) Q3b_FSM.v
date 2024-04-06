module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
     
    reg [2:0]y, Y;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        case (y)
            3'b000: Y = x?3'b001:3'b000;
            3'b001: Y = x?3'b100:3'b001;
            3'b010: Y = x?3'b001:3'b010;
            3'b011: Y = x?3'b010:3'b001;
            3'b100: Y = x?3'b100:3'b011;
            default: Y = 3'b000;
        endcase
    end

    always @(posedge clk) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if(reset) y <= 3'b000;
        else y <= Y;
    end

    // Output logic
    assign z = (y == 3'b100)|(y == 3'b011);

endmodule
