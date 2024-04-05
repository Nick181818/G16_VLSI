module top_module (
    input clk,
    input reset,          
    input [7:0] d,
    output [7:0] q
);
    reg[7:0] p;
    
    always@(posedge clk)
        begin 
            if(reset)
                begin 
                    p<=8'b0;
                end 
            else 
                begin 
                    p<=d; 
                end 
        end

    assign q=p;

endmodule
