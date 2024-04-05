module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    
    genvar i;
    
    FA x0(.a(a[0]), .b(b[0]), .cin(cin), .cout(cout[0]), .sum(sum[0]));
    generate 
        for(i=1; i<=99; i=i+1) begin: full_adder
            FA x1(.a(a[i]), .b(b[i]), .cin(cout[i-1]), .cout(cout[i]),.sum(sum[i]));
    end
    endgenerate
endmodule

module FA(
    input a,b,
    input cin,
    output cout,
    output sum);
    
    assign cout = (a & b) ^(b & cin) ^ (cin & a);
    assign sum = a ^ b ^ cin;
endmodule