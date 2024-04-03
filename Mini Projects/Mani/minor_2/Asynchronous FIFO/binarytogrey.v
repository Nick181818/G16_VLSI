module btog(input b[7:0],
output g[7:0]);
always@(posedge wr_clk)
begin
if(wr_rst!=0 && wr_en && wr_ptr[MSB]!=rd_ptr[MSB] && wr_ptr!=rd_ptr  ):
g[0]=b[0];
xor (g[1],b[0],b[1]);
xor (g[2],b[1],b[2]);
xor (g[3],b[2],b[3]);
xor (g[4],b[3],b[4]);
xor (g[5],b[4],b[5]);
xor (g[6],b[5],b[6]);
xor (g[7],b[6],b[7]);
end
endmodule