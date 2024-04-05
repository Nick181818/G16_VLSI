module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);

    reg [3:0]q1;

    always@(posedge clk)
        begin
            if(reset) 
                begin 
                    q1<=4'b0;
                end 
            else if(~reset && slowena==1 && q1<=4'b1000)
                    begin 
                        q1<=q1+1;
                    end 
            else if(~reset && slowena==0 && q1<=4'b1000) 
                begin 
                    q1<=q1; 
                end 
            else if(~reset && slowena==0 && q1==4'b1001)
                begin 
                    q1<=4'b1001;
                end 
            else
                begin 
                    q1<=4'b0;
                end
        end

    assign q=q1;
    
endmodule
