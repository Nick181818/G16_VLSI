module Fifo_Memory
//Set Fifo Depth 90 and Fifo Width 8  
    #(
        parameter S = 8, Depth = 8'b1001_0110
        )
(
    input wr_clk, //Write Clock  
    input rd_clk, //Read Clock  
    input [S-1:0] wr_ptr, //Write Pointer  
    input [S-1:0] rd_ptr, //Read Pointer  
    input wr_en, //Write Enable  
  	input rd_en, //Read Enable  
    input fifo_full, //Fifo Full Signal  
    input [7:0] wr_data, //Write Data  
    output reg [7:0] rd_data //Read data  
);
    
    // Memory Declaration
    reg [7:0] Memory [0:Depth-1];
    
    always @ (posedge wr_clk)
    begin
        if (wr_en && !fifo_full)
            Memory [wr_ptr] <= wr_data;
        else
            Memory [wr_ptr] <= Memory[wr_ptr];
    end

    //Ouput storing in Read Data 
    always @ (posedge rd_clk)
    begin
      if(rd_en)
        rd_data <= Memory[rd_ptr];
      else 
        rd_data <= rd_data;
    end
    
endmodule