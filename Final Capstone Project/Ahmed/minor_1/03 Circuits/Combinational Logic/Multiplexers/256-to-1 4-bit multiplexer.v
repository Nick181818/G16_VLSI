module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
    
    // Selecting 1-bit at time and, then concatenating all 4-bits 
    assign out = {in[sel*4+3], in[sel*4+2], in[sel*4+1], in[sel*4+0]};
    
    //Another ways of doing it by taking as a vector
    // assign out = in[4*sel +: 4]; //this done by increasing index number using (+:).
    // assign out = in[4*sel+3 -: 4]; //this done by decreasing index number using (-:).
    
endmodule