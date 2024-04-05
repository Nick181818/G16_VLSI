module top_module( 
    input [99:0] a, b,
    input cin,
    output  [99:0] cout,
    output  [99:0] sum );
    
    wire [99:0]intermediate;
    FA fa0(.a(a[0]),.b(b[0]),.cin(cin),.sum(sum[0]),.cout(intermediate[0]));
    FA fa99(.a(a[99]),.b(b[99]),.cin(intermediate[98]),.sum(sum[99]),.cout(intermediate[99]));
    genvar i;
    generate 
        for(i=1;i<99;i=i+1)
            begin:full_adder
                FA fai(.a(a[i]),.b(b[i]),.cin(intermediate[i-1]),.sum(sum[i]),.cout(intermediate[i]));
            end
    endgenerate

    assign cout[99:0]=intermediate [99:0];
    
endmodule

module FA(input a,b,cin,
          output cout,sum);
    
    assign sum=a^b^cin;
    assign cout=a&b|b&cin|cin&a;
    
endmodule
