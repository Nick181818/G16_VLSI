//
// Dual Flop synchronizer
//
module synchronizer
#(
  parameter ADDRSIZE = 8 // Pointer Size
)
(
  input   clk, // Clock Signal
  input   rst, // Reset Signal
  input   [ADDRSIZE-1:0] in_ptr, // Input Pointer Value
  output reg  [ADDRSIZE-1:0] sync_ptr //Synchronized pointer
);

  reg [ADDRSIZE-1:0] temp_ptr; // Temporary Pointer value

  always @(posedge clk or posedge rst) 
  begin
    if (rst)
    begin 
	temp_ptr <= 0;
	sync_ptr <= 0;
    end
    else
    begin 
	temp_ptr <= in_ptr;
	sync_ptr <= temp_ptr;
    end
  end

endmodule
