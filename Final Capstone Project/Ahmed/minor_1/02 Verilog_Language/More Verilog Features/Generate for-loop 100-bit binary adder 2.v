module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    integer i;
    reg c;
    always @ (*)
        begin
        c = cin;
            for(i=0; i<100;i=i+1) begin
                {cout[i],sum[i]} = a[i]+b[i]+c;
                c = cout[i];
            end
        end
    
endmodule