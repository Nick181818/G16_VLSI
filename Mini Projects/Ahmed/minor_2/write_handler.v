module write_handler
#(
  parameter ADDRSIZE = 8,
  parameter DEPTH = 90
)
(
  input   wr_en, // Write Enable Signal
  input   wr_clk, // Write Clock Signal
  input   wr_rst, // Active High Reset for Write pointer 
  input   [ADDRSIZE-1:0] rptr, // Synchronized Read pointer
  output reg  wfull, // FIFO Full Signal
  output  [ADDRSIZE-1:0] wptr // Write Pointer value
);

   reg [ADDRSIZE-1:0] wbin; //Temporary Write Pointer value

// Updating Write pointer value
  always @ (posedge wr_clk or posedge wr_rst)
    begin
        if (wr_rst)
            wbin <= 0;
      else if (!wr_rst && wr_en && !wfull && (wbin[ADDRSIZE-2:0] < DEPTH-1))
        begin
            wbin[ADDRSIZE-2:0] <= wbin[ADDRSIZE-2:0] + 1;
            wbin[ADDRSIZE-1] <= wbin[ADDRSIZE-1];
        end
      else if (!wr_rst && wr_en && !wfull && (wbin[ADDRSIZE-2:0] == DEPTH-1))
        begin
            wbin[ADDRSIZE-2:0] <= 0;
            wbin[ADDRSIZE-1] <= ~wbin[ADDRSIZE-1];
        end
        else
            wbin <= wbin;
    end
    
// FIFO Full Logic
  always @(*)
   begin
     if ( (wptr[ADDRSIZE-1] != rptr[ADDRSIZE-1]) && (wptr[ADDRSIZE-2:0] == rptr[ADDRSIZE-2:0]) )
       wfull <= 1'b1;
     else
       wfull <= 1'b0;
   end
  
  assign wptr = wbin;

endmodule
