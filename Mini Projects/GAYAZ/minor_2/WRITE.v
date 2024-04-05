module write #(parameter N = 8, depth = 8'b1010_1010)(
        input wr_clk,
        input wr_en,
        input wr_rst,
        input [N-1:0] rdPtr,
        output [N-1:0] wrPtr,
        output reg o_fifo_full
    );
    
  
    
    reg [N-1:0]counter;
    
    always @ (posedge wr_clk or posedge wr_rst)
    begin
        if (wr_rst)
            counter <= 0;
        else if (!wr_rst && wr_en && !o_fifo_full && (counter[N-2:0] < depth-1))
        begin
            counter[N-2:0] <= counter[N-2:0] + 1;
            counter[N-1] <= counter[N-1];
        end
      else if (!wr_rst && wr_en && !o_fifo_full && (counter[N-2:0] == depth-1))
        begin
            counter[N-2:0] <= 0;
            counter[N-1] <= ~counter[N-1];
        end
        else
            counter <= counter;
    end
    
    always @ (*)
    begin
        if ((wrPtr[N-1] != rdPtr[N-1]) && (wrPtr[N-2:0] == rdPtr[N-2:0]))
            o_fifo_full = 1'b1;
        else
            o_fifo_full = 1'b0;
    end
    
    assign wrPtr = counter;
    
endmodule