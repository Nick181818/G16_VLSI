module Synchronizer#(parameter N = 8)(
  input [N-1:0] data_in,
  output reg [N-1:0] data_out,
    input clk,
    input rst
    );
  reg [N-1:0] dual_1to2;  
    always @ (posedge clk or posedge rst)
    begin
        if (rst == 1'b1)
        begin
            dual_1to2 <= 0;
            data_out <= 0;
        end
        else
        begin
            dual_1to2 <= data_in;
            data_out <= dual_1to2;
        end 
    end
endmodule