module top_module( 
    input a, b,
    output cout, sum );
    
	assign sum = a^b,
        cout = a&b;
endmodule