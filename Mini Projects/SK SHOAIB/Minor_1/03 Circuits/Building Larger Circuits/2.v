module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);
    
    reg [3:0] a;

    always@(posedge clk)
        begin
            if(shift_ena)
                begin 
                    a[0]<=data;
                    a[1]<=a[0];
                    a[2]<=a[1];
                    a[3]<=a[2];
                end
            else if(~shift_ena && count_ena)
                a<=a-1;
        end
        
    assign q=a;

endmodule
