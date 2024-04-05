module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    
    wire [399:0] carryout_wire;
    
    bcd_fadd x1(a[3:0], b[3:0], cin, carryout_wire[0], sum[3:0]);
    generate 
        genvar i;
        for(i=4; i<400; i=i+4) begin: bcd_full_adder
            bcd_fadd x2(.a(a[i+3:i]), .b(b[i+3:i]), .cin(carryout_wire[i-4]), .cout(carryout_wire[i]), .sum(sum[i+3:i]));
        end
    endgenerate
        
    assign cout = carryout_wire[396];
endmodule
