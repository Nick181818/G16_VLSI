module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
);
    reg [31:0]p;

    always@(posedge clk)
        begin 
            if(reset) 
                p<=32'h1;
            else 
                begin
                    p<={p[0],p[31:23],p[22]^p[0],p[21:3],p[2]^p[0],p[1]^p[0]};
                end
        end
        
    assign q=p;

endmodule
