module writelogic(input wr_rst,input wr_clk,input wr_en,
input wr_ptr,output data_in[7:0]);
integer i;
begin
always@(posedge wr_clk or posedge wr_rst)
if (wr_rst):
wr_ptr=0;
elseif(wr_rst!=1 && wr_en && o_fifo_full!=1):
begin
for (i=0;i<=90;i++):
begin
wr_ptr<=wr_ptr+1;
wr_ptr[PTRWIDTH-1:0]<=data_in[7:0];
end
end
end

endmodule

