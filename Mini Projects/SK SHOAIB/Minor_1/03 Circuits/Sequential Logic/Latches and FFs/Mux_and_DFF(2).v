module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    reg q;
    reg [1:0]p;
    assign p={E,L};

    always@(posedge clk)
        begin
           case(p)
                2'b00:q<=q;
                2'b01:q<=R;
                2'b10:q<=w;
                2'b11:q<=R;
                default:q<=1'b0;
            endcase 
        end

    assign Q=q;
    
endmodule
