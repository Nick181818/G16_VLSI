module top_module( 
    input [255:0] in,
    input [7:0] sel,
    output out );
    
    //Selecting one bit from input  
    assign out = in[sel];
    
endmodule