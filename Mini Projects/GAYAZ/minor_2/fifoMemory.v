module fifoMemory#(parameter N = 8, depth = 8'b0101_1010)(
        input wr_clk,
        input rd_clk,
        input [N-1:0] wrPtr,
        input [N-1:0] rdPtr,
        input wr_en,
        input rd_en,          
  input [7:0] wr_data,
  output reg [7:0] rd_data
    );
    
    // Declaring memory
    reg [7:0] RAM [0:depth-1];
    
    //
    always @ (posedge wr_clk)
    begin
        if (wr_en)
            RAM [wrPtr] <= wr_data;
        else
            RAM [wrPtr] <= RAM[wrPtr];
    end
    
    always @ (posedge rd_clk)
    begin
      if(rd_en)
          rd_data <= RAM[rdPtr];
      else
        rd_data<=rd_data;
    end
    
endmodule