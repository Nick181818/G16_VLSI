module dff_Synchronizer #(parameter d=8)(
  
    input [d-1:0] data_in,
    output reg [d-1:0] data_out,
    input clk,
    input rst
);
    
  reg [d-1:0] p;
    
    always @ (posedge clk or posedge rst)
      begin
        if(rst)
          begin
            p<=0;
            data_out<=0;
          end
        else
          begin 
            p<=data_in;
            data_out<=p;
        end 
      end
  
endmodule
