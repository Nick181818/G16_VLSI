module gtob(input clk,input g[7:0],
output b[7:0]);
always @(posedge clk)
if (rd_en && rd_ptr[MSB]!=wr_ptr[MSB] && rd_rst!=1 && rd_ptr[MSB-1:0]!=wr_ptr[MSB-1:0]):
b[7]=g[7];
xor (b[6],b[7],g[6]);
xor (b[5],b[6],g[5]);
xor (b[4],b[5],g[4]);
xor (b[3],b[4],g[3]);
xor (b[2],b[3],g[2]);
xor (b[1],b[2],g[1]);
xor (b[0],b[1],g[0]);
endmodule