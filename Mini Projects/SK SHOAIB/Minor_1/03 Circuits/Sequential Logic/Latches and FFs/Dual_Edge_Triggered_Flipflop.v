module top_module (
    input clk,
    input d,
    output q
);
    reg p,s;

    always@(posedge clk)
        begin 
            p<=d;
        end 

    always@(negedge clk)
		begin 
            s<=d;
        end

	always@(*) 
        begin 
            if(clk)
                q=p;
            else 
                q=s; 
        end


endmodule
