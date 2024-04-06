module Mem#(parameter N = 8, depth = 90)(
        input wr_clk,
        input rd_clk,
  		input [N-1:0] wr_ptr,
  		input [N-1:0] rd_ptr,
        input wr_en,
        input rd_en,          
  input [7:0] wr_data,
  output reg [7:0] rd_data
    );  
    // Declaring memory
    reg [7:0] RAM [0:depth-1];
  
  always @ (posedge wr_clk)
    begin
      if (wr_en)
        RAM [wr_ptr] <= wr_data;
        else
          RAM [wr_ptr] <= RAM[wr_ptr];
    end    
  always @ (posedge rd_clk)
    begin
      if(rd_en)
        rd_data <= RAM[rd_ptr];
      else
        rd_data<=rd_data;
    end    
endmodule