module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
    
    reg [511:0]p;
    
    always@(posedge clk) 
        begin 
            if(load) 
                p<=data;
            else 
                p<={1'b0, p[511:1]} ^ {p[510:0], 1'b0};
    end
    
    assign q=p;
 

endmodule
