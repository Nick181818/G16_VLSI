module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    genvar i;
    fadd fd1(.a(a[0]),.b(b[0]),.cin(cin),.sum(sum[0]),.cout(cout[0]));
    generate 
        for ( i=1;i<100;i=i+1) 
            begin : faddr
            fadd fd(.a(a[i]),.b(b[i]),.cin(cout[i-1]),.sum(sum[i]),.cout(cout[i]));
        end
    endgenerate
  endmodule
module fadd( output sum,cout,input a,b,cin);
    assign sum = a^b^cin;
    assign cout = (a&b) |(b&cin)|(cin&a);
endmodule
