module read_Unit 
//Set Fifo Depth 90 and Fifo Width 8  
    #(
        parameter S = 8, Depth = 8'b1001_0110
        )
 (
  input rd_clk, //Read Clock  
  input rd_en, //Read Enable  
  input rd_rst, //Read Reset  
  input [S-1:0] wr_ptr, //Write Pointer  
  output [S-1:0] rd_ptr, //Read Pointer  
  output reg fifo_empty //Fifo Empty  
);

reg [S-1:0]counter; //Temporary Read Pointer
    
always @ (posedge rd_clk or posedge rd_rst)
begin
    if (rd_rst)
        counter <= 0;
    else if (!rd_rst && rd_en && !fifo_empty && (counter[S-2:0] < Depth-1))
    begin
        counter[S-2:0] <= counter[S-2:0] + 1;
        counter[S-1] <= counter[S-1];
    end
    else if  (rd_en && !fifo_empty && (counter[S-2:0] == Depth-1))
    begin
        counter[S-2:0] <= 0;
        counter[S-1] <= ~counter[S-1];
    end
    else
        counter <= counter;
end

//Fifo Empty Logic  
always @ (*)
begin
    if ((wr_ptr[S-1] == rd_ptr[S-1]) && (wr_ptr[S-2:0] == rd_ptr[S-2:0]))
        fifo_empty = 1'b1;
    else
        fifo_empty = 1'b0;
end

assign rd_ptr = counter;

endmodule