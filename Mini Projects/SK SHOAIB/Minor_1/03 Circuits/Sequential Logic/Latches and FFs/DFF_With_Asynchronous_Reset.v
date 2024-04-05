module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);
    reg [7:0] p;
    
    always@(posedge clk or posedge areset)
        begin
            if(areset)
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
