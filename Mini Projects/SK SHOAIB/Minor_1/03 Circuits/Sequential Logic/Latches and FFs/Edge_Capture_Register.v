module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] prev_in; 

    always @(posedge clk) 
        begin 
            if (reset) 
                begin 
                    out <= 32'b0; 
            else 
                begin 
                    for (integer i = 0; i < 32; i = i + 1) 
                        begin
                            if (prev_in[i] && !in[i]) 
                                begin 
                                    out[i] <= 1'b1;  
                                end 
                        end 
                end 

            prev_in = in;  
            
        end

endmodule



