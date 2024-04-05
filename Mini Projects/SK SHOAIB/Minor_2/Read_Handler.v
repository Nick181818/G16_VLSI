module read#(parameter d = 8, depth =90)(
  
        input rdclk,
        input rden,
        input rdrst,
        input [d-1:0] wrPtr,
        output [d-1:0]rdPtr,
        output reg fifo_empty      
);
    
   
    
  reg [d-1:0]cnt;
    
  always @ (posedge rdclk or posedge rdrst)
    begin
      if(rdrst)
        cnt<=0;
      else if(!rdrst && rden && !fifo_empty && (cnt[d-2:0] < depth-1))
        begin
          cnt[d-2:0]<=cnt[d-2:0]+1;
          cnt[d-1]<=cnt[d-1];
        end
      else if(!rdrst && rden && !fifo_empty && (cnt[d-2:0] == depth-1))
        begin
          cnt[d-2:0]<=0;
          cnt[d-1]<= ~cnt[d-1];
        end
      else
        cnt<=cnt;
    end
    
    always @ (*)
      begin
        if((wrPtr[d-1] == rdPtr[d-1]) && (wrPtr[d-2:0] == rdPtr[d-2:0]))
          fifo_empty=1'b1;
        else
          fifo_empty=1'b0;
      end
  
  assign rdPtr=cnt;
    
endmodule
