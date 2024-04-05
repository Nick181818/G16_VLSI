module write #(parameter d = 8, depth =90)(
        input wrclk,
        input wren,
        input wrrst,
        input [d-1:0] rdPtr,
        output [d-1:0]wrPtr,
        output reg fifo_full
);
    
    
  reg [d-1:0]cnt;
    
  always @ (posedge wrclk or posedge wrrst)
    begin
      if(wrrst)
        cnt<=0;
      else if(!wrrst && wren && !fifo_full && (cnt[d-2:0] < depth-1))
        begin
          cnt[d-2:0]<=cnt[d-2:0]+1;
          cnt[d-1]<=cnt[d-1];
        end
      else if(!wrrst && wren && !fifo_full && (cnt[d-2:0] == depth-1))
        begin
          cnt[d-2:0]<=0;
          cnt[d-1]<= ~cnt[d-1];
        end
      else
        cnt<=cnt;
    end
    
    always @ (*)
      begin
        if((wrPtr[d-1] != rdPtr[d-1]) && (wrPtr[d-2:0] == rdPtr[d-2:0]))
          fifo_full=1'b1;
        else
          fifo_full=1'b0;
      end
  
  assign wrPtr=cnt;
    
endmodule
