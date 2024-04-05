module rdptr#(parameter N = 8, depth =90)(
        input rd_clk,
        input rd_en,
        input rd_rst,
  input [N-1:0] wr_ptr,
  output [N-1:0]rd_ptr,
        output reg fifo_Empty      
    );
  reg [N-1:0]count;
    
  always @ (posedge rd_clk or posedge rd_rst)
    begin
      if (rd_rst)
            count <= 0;
      else if (!rd_rst && rd_en && !fifo_Empty && (count[N-2:0] < depth-1))
        begin
            count[N-2:0] <= count[N-2:0] + 1;
            count[N-1] <= count[N-1];
        end
      else if (!rd_rst && rd_en && !fifo_Empty && (count[N-2:0] == depth-1))
        begin
            count[N-2:0] <= 0;
            count[N-1] <= ~count[N-1];
        end
        else
            count <= count;
    end
    
    always @ (*)
    begin
      if((wr_ptr[N-1] == rd_ptr[N-1]) && (wr_ptr[N-2:0] == rd_ptr[N-2:0]))
            fifo_Empty = 1'b1;
        else
            fifo_Empty = 1'b0;
    end
    
    assign rd_ptr = count;
    
endmodule
