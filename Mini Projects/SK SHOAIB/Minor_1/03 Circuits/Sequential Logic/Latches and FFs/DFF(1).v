module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q);
    
    reg p;
    
    always@(posedge clk or posedge ar)
        begin 
            if(ar) 
                begin 
                    p<=1'b0;
                end 
            else 
                begin
                    p<=d;
                end 
        end

    assign q=p;
    
endmodule
