module top_module (
    input clk,
    input resetn, // synchronous reset
    input in,
    output out
);
    reg [2:0]p;
    reg [2:0]q;

    always@(posedge clk)
        begin
            if(~resetn)
                begin 
                    p<=3'b000;
                    q<=1'd0;
                end
            else 
                begin 
                    p[2]<=in;
                    p[1]<=p[2];
                    p[0]<=p[1];
                    q<=p[0];
                end 
        end
        
    assign out=q;
            
endmodule
  