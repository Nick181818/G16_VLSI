module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
    reg [100:0]temp;
	assign temp = a + b + cin; 
    assign sum[99:0]=temp[99:0];
    assign cout=temp[100]; 
endmodule
