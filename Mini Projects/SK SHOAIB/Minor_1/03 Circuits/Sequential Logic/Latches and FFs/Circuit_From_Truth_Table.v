module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    
    reg [1:0]p;
    reg q;
    assign p={j,k};
    
    always@(posedge clk)
        begin 
            case(p)
                2'b00:q<=q;
                2'b01:q<=1'b0;
                2'b10:q<=1'b1;
                2'b11:q<=~q;
            endcase 
        end 

    assign Q=q;

endmodule
