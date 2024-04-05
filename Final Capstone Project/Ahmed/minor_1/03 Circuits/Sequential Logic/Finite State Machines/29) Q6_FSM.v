module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);

    parameter A = 3'b000, B = 3'b001,C = 3'b010,D = 3'b011,E = 3'b100, F = 3'b101;
    reg [3:1]y, Y;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        case (y)
            A : Y = w ? A:B;
            B : Y = w ? D:C;
            C : Y = w ? D:E;
            D : Y = w ? A:F;
            E : Y = w ? D:E;
            F : Y = w ? D:C;
        endcase
    end
    
    always @(posedge clk )begin
        if(reset) y <= A;
        else y <= Y;
    end

    // Output logic
    assign z = (y==E)|(y==F);
    
endmodule
