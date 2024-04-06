module Memory#(parameter d = 8, depth = 90)(
        input wrclk,
        input rdclk,
        input [d-1:0] wrPtr,
        input [d-1:0] rdPtr,
        input wren,
        input rden,          
        input [7:0] wrData,
        output reg [7:0] rdData
    );
    
   
  reg [7:0] memo [0:depth-1];
    
 
  always @(posedge wrclk)
    begin
      if (wren)
            memo[wrPtr]<=wrData;
        else
          memo[wrPtr]<=memo[wrPtr];
    end
    
  always @(posedge rdclk)
    begin
      if(rden)
          rdData<=memo[rdPtr];
      else
        rdData<=rdData;
    end
    
endmodule
