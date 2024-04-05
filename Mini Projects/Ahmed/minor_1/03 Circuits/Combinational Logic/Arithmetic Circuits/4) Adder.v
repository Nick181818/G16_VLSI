module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    wire [2:0] cout;
    
    FA FA1(.A(x[0]),.B(y[0]),.Cin(0),.Cout(cout[0]),.Sum(sum[0]) );
    FA FA2(.A(x[1]),.B(y[1]),.Cin(cout[0]),.Cout(cout[1]),.Sum(sum[1]) );
    FA FA3(.A(x[2]),.B(y[2]),.Cin(cout[1]),.Cout(cout[2]),.Sum(sum[2]) );
    FA FA4(.A(x[3]),.B(y[3]),.Cin(cout[2]),.Cout(sum[4]),.Sum(sum[3]) );
    
endmodule

module FA(
    input A, B, Cin,
    output Sum,Cout
    );
    assign {Cout,Sum} = A+B+Cin;
endmodule