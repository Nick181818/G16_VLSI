module read#(parameter N = 8, depth = 8'b0101_1010)(
        input rd_clk,
        input rd_en,
        input rd_rst,
        input [N-1:0] wrPtr,
        output [N-1:0]rdPtr,
        output reg o_fifo_empty      
    );
    
   
    reg [N-1:0]counter;
    
    always @ (posedge rd_clk or posedge rd_rst)
    begin
        if (rd_rst)
            counter <= 0;
        else if (!rd_rst && rd_en && !o_fifo_empty && (counter[N-2:0] < depth-1))
        begin
            counter[N-2:0] <= counter[N-2:0] + 1;
            counter[N-1] <= counter[N-1];
        end
        else if (!rd_rst && rd_en && !o_fifo_empty && (counter[N-2:0] == depth-1))
        begin
            counter[N-2:0] <= 0;
            counter[N-1] <= ~counter[N-1];
        end
        else
            counter <= counter;
    end
    
    always @ (*)
    begin
        if((wrPtr[N-1] == rdPtr[N-1]) && (wrPtr[N-2:0] == rdPtr[N-2:0]))
            o_fifo_empty = 1'b1;
        else
            o_fifo_empty = 1'b0;
    end
    
    assign rdPtr = counter;
    
endmodule