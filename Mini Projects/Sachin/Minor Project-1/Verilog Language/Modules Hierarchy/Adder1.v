module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum);
    
    //Interconnections
    wire cout, cin;
    
    //add16 module logic
    add16 (.sum(sum[15:0]), .cout(cout), .a(a[15:0]), .b(b[15:0]), .cin(cin));
    add16 (.sum(sum[31:16]), .a(a[31:16]), .b(b[31:16]), .cin(cout));
endmodule
    
    