module top_module (
    input d, 
    input ena,
    output q);
    always @(*) begin
        if(ena==1)
            q <= d;
   		 else ;
    end
endmodule
