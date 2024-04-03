module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);
    parameter A = 3'b000, B = 3'b001,C = 3'b010,D = 3'b011,E = 3'b100, F = 3'b101;
    reg [3:1]y, Y;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        case (y)
            A : Y = w ? B:A;
            B : Y = w ? C:D;
            C : Y = w ? E:D;
            D : Y = w ? F:A;
            E : Y = w ? E:D;
            F : Y = w ? C:D;
        endcase
    end
    
    always @(posedge clk )begin
        if(reset) y <= A;
        else y <= Y;
    end

    // Output logic
    assign z = (y==E)|(y==F);

endmodule
