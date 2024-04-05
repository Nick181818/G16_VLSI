module readlogic(input rd_rst,input rd_clk, input rd_en,
input rd_ptr, output data_out[7:0]);
integer i;
begin
always@(posedge rd_clk)
if(rd_rst)
rd_ptr=0;
elseif(rd_rst=0 && rd_en && o_fifo_empty=0):
begin
for (i=0;i<=90;i=i+1):
begin
rd_ptr<=rd_ptr+1;
data_out[7:0]<=rd_ptr[PTRWIDTH-1:0];
end
end
end
endmodule