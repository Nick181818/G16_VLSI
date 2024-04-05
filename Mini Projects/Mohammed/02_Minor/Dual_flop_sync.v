module Dual_flop_sync 
//Set Parameter 
    #(
         parameter S = 8
         )
(
    input clk,
    input rst,
    input [S-1:0] data_in,
    output reg [S-1:0] data_out
);


reg [S-1:0] Connection;

always @ (posedge clk or posedge rst)
begin
    if (rst == 1'b1)
    begin
        Connection <= 0;
        data_out <= 0;
    end
    else
        begin
            Connection <= data_in;
            data_out <= Connection;
        end

end
endmodule