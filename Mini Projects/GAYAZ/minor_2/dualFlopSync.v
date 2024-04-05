module dualFlopSync#(parameter N = 8)(
    input [N-1:0] dataIn,
    output reg [N-1:0] dataOut,
    input clk,
    input rst
    );
    
    reg [N-1:0] netFlop1to2;
    
    always @ (posedge clk or posedge rst)
    begin
        if (rst == 1'b1)
        begin
            netFlop1to2 <= 0;
            dataOut <= 0;
        end
        else
        begin
            netFlop1to2 <= dataIn;
            dataOut <= netFlop1to2;
        end 
    end
endmodule