module top_module( 
    input [2:0] in,
    output [1:0] out );
    reg [2:0]c;
    integer i;
    always @(*)
        begin
            c=3'b000;
            for (i=0;i<3;i=i+1)
                begin
                    if(in[i]==1)
                        c=c+1;
                end
            out = c;
        end
endmodule
