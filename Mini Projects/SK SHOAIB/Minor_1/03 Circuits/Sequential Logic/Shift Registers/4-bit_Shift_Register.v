module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input reg [3:0] data,
    output reg [3:0] q); 
    
    always@(posedge clk or posedge areset)
        begin 
            if(areset)
                q<=4'b0;
            else 
                begin 
                    if(load) 
                        q<=data; 
                    else if(ena) 
                        begin 
                            q[3]<=1'b0; 
                            q[2]<=q[3];
                            q[1]<=q[2];
                            q[0]<=q[1]; 
                        end
                end 
        end

endmodule
