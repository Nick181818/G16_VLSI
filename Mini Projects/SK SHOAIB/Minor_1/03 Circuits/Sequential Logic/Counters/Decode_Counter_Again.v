module top_module (
    input clk,
    input reset,
    output [3:0] q);
    
    reg [3:0]q1;

    always@(posedge clk)
        begin 
            if(reset)
                begin 
                    q1<=4'b00001;
                end 
            else if(q1<=4'b1001)
                begin
                    q1<=q1+1;
                end 
            else 
                begin
                    q1<=4'b0001; 
                end 
        end 
        
    assign q=q1;

endmodule
