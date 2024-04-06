module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
    reg [15:0]q1;
    
    always@(posedge clk)
        begin 
            if(~resetn)
                begin 
                    q1<=16'b0;
                end 
            else 
                begin 
                    if(byteena[1])
                        begin 
                            q1[15:8]<=d[15:8];
                        end 
                    if(byteena[0])
                        begin
                            q1[7:0]<=d[7:0];
                        end 
                end 
        end 

    assign q=q1;

endmodule
