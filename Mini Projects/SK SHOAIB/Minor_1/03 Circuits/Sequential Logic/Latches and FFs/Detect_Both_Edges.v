module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);
    reg [7:0] p;
    
    always@(posedge clk)
        begin 
            if(clk)
                begin 
                    p<=in; 
                    anyedge<=in^p;
                end 
        end
            

endmodule
