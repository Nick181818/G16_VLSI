module top_module( 
    input [99:0] in,
    output [99:0] out
);
integer s;
    always @(*)
        begin
            for(s=0;s<100;s++)
                out[s]=in[99-s];
        end
endmodule
