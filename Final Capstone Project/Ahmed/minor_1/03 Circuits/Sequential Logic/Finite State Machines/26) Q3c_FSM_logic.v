module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    reg  [2:0]Y;

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

    // Output logic
    assign z = (y == 3'b100)|(y == 3'b011);
    assign Y0 = Y[0];

endmodule