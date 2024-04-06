module control_unit(
  
  input clk_in,
  input rst_in,
  output reg flush_out,
  output reg [1:0] pc_src_out

);
  
   parameter rst=0,operate=1; 
   reg state,next;

   always @(*)
     begin 
       case(state)
         rst   : next = operate;
         operate : next = operate;
        endcase
    end

    always @(posedge clk_in) 
      begin 
        if(rst_in)
          state <= rst;
        else 
          state <= next;
      end

    
    always @(*)
      begin
        if (state == rst) 
          begin
            flush_out = 1'b1;
            pc_src_out = 2'b00;
          end 
        else 
          begin
            flush_out = 1'b0;
            pc_src_out = 2'b11;
          end
      end
    
endmodule
