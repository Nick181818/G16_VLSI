module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
 
    reg [7:0] cout;
    assign {cout[0],s[0]} = a[0]+b[0], 
    {cout[1],s[1]} = a[1]+b[1]+cout[0],
    {cout[2],s[2]} = a[2]+b[2]+cout[1],
    {cout[3],s[3]} = a[3]+b[3]+cout[2],
    {cout[4],s[4]} = a[4]+b[4]+cout[3],
    {cout[5],s[5]} = a[5]+b[5]+cout[4],
    {cout[6],s[6]} = a[6]+b[6]+cout[5],
    {cout[7],s[7]} = a[7]+b[7]+cout[6];

    
    assign overflow = cout[7] ^ cout[6];

endmodule