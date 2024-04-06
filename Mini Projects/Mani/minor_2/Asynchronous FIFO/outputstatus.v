always@(posedege clk) 
begin
if (wr-ptr[MSB]==rd-ptr[MSB]&& wr-ptr[MSB-1:0]==rd-ptr[MSB-1:0]):
o_fifo_full=1;
elseif(wr-ptr[MSB]!=rd-ptr[MSB]&&wr-ptr[MSB-1:0]==rd-ptr[MSB-1:0]):
o_fifo_empty=1;
end