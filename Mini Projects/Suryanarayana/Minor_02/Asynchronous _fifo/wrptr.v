module wrptr #(parameter N = 8, depth = 90)(
        input wr_clk,
        input wr_en,
        input wr_rst,
  		input [N-1:0] rd_ptr,
  		output [N-1:0]wr_ptr,
        output reg fifo_Full
    );
       
    reg [N-1:0]count;
    
  always @ (posedge wr_clk or posedge wr_rst)
    begin
      if (wr_rst)
            count <= 0;
      else if (!wr_rst && wr_en && !fifo_Full && (count[N-2:0] < depth-1))
        begin
            count[N-2:0] <= count[N-2:0] + 1;
            count[N-1] <= count[N-1];
        end
      else if (!wr_rst && wr_en && !fifo_Full && (count[N-2:0] == depth-1))
        begin
            count[N-2:0] <= 0;
            count[N-1] <= ~count[N-1];
        end
        else
            count <= count;
    end
    
    always @ (*)
    begin
      if ((wr_ptr[N-1] != rd_ptr[N-1]) && (wr_ptr[N-2:0] == rd_ptr[N-2:0]))
            fifo_Full = 1'b1;
        else
            fifo_Full = 1'b0;
    end  
    assign wr_ptr = count; 
endmodule