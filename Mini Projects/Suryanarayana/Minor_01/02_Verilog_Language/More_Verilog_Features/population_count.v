module top_module( 
    input [254:0] in,
    output [7:0] out );
    wire [7:0]s;
    integer i;
    always @(*)
        begin
            s=0;
            for (i=0;i<255;i=i+1)
                begin
                    if (in[i]==1)
                        s=s+1;
                end
            out = s;
        end
endmodule
