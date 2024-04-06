module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow); 
 
    reg c;
    assign s = a+b;
    always@(*)
        begin 
            if(a[7]==b[7] && (s[7]!=a[7]|s[7]!=b[7])) 
                begin 
                    c=1'b1; 
                end
            else 
                begin
                    c=1'b0;
                end
        end
            
    assign overflow=c;

endmodule
