module write_Unit 
//Set Fifo Depth 90 and Fifo Width 8  
    #(
        parameter S = 8, Depth = 8'b1001_0110
        )
(
  input wr_clk, //Write Clock  
  input wr_en, //Write Enable  
  input wr_rst, //Write Reset  
  input [S-1:0] rd_ptr, //Read Pointer  
  output [S-1:0] wr_ptr, //Write Pointer  
  output reg fifo_full //Fifo Full
);

reg [S-1:0]counter; //Temporary Write Pointer
    
always @ (posedge wr_clk or posedge wr_rst)
begin
    if (wr_rst)
        counter <= 0;
    else if (!wr_rst && wr_en && !fifo_full && (counter[S-2:0] < Depth-1))
    begin
        counter[S-2:0] <= counter[S-2:0] + 1;
        counter[S-1] <= counter[S-1];
    end
    else if (!wr_rst && wr_en && !fifo_full && (counter[S-2:0] == Depth-1))
    begin
        counter[S-2:0] <= 0;
        counter[S-1] <= ~counter[S-1];
    end
    else
        counter <= counter;
end

//Full Logic  
always @ (*)
begin
    if ((wr_ptr[S-1] != rd_ptr[S-1]) && (wr_ptr[S-2:0] == rd_ptr[S-2:0]))
        fifo_full = 1'b1;
    else
        fifo_full = 1'b0;
end

assign wr_ptr = counter;

endmodule