module top_module (
    input [2:0] a,
    output [15:0] q ); 
    
    reg [15:0]p;
    
    always@(*)
        begin
            case(a)
                3'd1:p=16'haee0;
                3'd2:p=16'h27d4;
                3'd3:p=16'h5a0e;
                3'd4:p=16'h2066;
                3'd5:p=16'h64ce;
                3'd6:p=16'hc526;
                3'd7:p=16'h2f19;
                default:p=16'h1232;
            endcase
        end

    assign q=p;

endmodule
