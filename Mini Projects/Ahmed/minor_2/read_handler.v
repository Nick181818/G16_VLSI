module read_handler
#(
  parameter ADDRSIZE = 8, // Address size
  parameter DEPTH = 90 // Depth of Memory
)
(
  input   rd_en, // Read Enable Signal
  input   rd_clk, // Read Clock Signal
  input   rd_rst, // Active High Reset for read pointer 
  input   [ADDRSIZE-1 :0] wptr, // Synchronized Write pointer value 
  output  reg rempty, // FIFO Empty Signal
  output  [ADDRSIZE-1:0] rptr // Read pointer value
);

  reg [ADDRSIZE-1:0] rbin; // Temporary read pointer value

// Updating read pointer value
  always @ (posedge rd_clk or posedge rd_rst)
    begin
      if (rd_rst)
        rbin <= 0;
      else if (!rd_rst && rd_en && !rempty && (rbin[ADDRSIZE-2:0] < DEPTH-1))
        begin
          rbin[ADDRSIZE-2:0] <= rbin[ADDRSIZE-2:0] + 1;
          rbin[ADDRSIZE-1] <= rbin[ADDRSIZE-1];
        end
      else if (rd_en && !rempty && (rbin[ADDRSIZE-2:0] == DEPTH-1))
        begin
            rbin[ADDRSIZE-2:0] <= 0;
            rbin[ADDRSIZE-1] <= ~rbin[ADDRSIZE-1];
        end
      else
        rbin <= rbin;
    end
  
  // FIFO empty logic
  always @(*)
   begin
     if ( (wptr[ADDRSIZE-1] == rptr[ADDRSIZE-1]) && (wptr[ADDRSIZE-2:0] == rptr[ADDRSIZE-2:0]))
       rempty <= 1'b1;
     else
       rempty <= 1'b0;
   end

  assign rptr = rbin;

endmodule
