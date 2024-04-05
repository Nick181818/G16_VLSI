module control_unit(
  					input clk_in,
 				    input rst_in,
  					output reg [1:0]pc_src_o,
  					output reg flush_o		
					);
  always @ (posedge clk_in)
     begin 
      if(rst_in)
        begin
        pc_src_o<=2'b00;
        flush_o<=1;
        end
      else 
        begin
        pc_src_o<=2'b11;
        flush_o<=0;
        end
    end 
endmodule

