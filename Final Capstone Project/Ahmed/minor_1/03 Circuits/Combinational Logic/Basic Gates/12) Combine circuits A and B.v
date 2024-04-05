module top_module (input x, input y, output z);
    //Declaring wires
    wire [3:0]mod_out;
    wire [1:0]gate_out;
    
    //Instantiating modules
    A a1( .x(x), .y(y), .z(mod_out[0]) );
    B b1( .x(x), .y(y), .z(mod_out[1]) );
    A a2( .x(x), .y(y), .z(mod_out[2]) );
    B b2( .x(x), .y(y), .z(mod_out[3]) );
    
    assign gate_out[0] = |mod_out[1:0];
    assign gate_out[1] = &mod_out[3:2];
    assign z = ^gate_out[1:0];

endmodule

//Describing submodule A
module A (input x, input y, output z);
 assign z = (x^y) & x;
endmodule
//********

//Describing submodule B
module B ( input x, input y, output z );
    always @ (x or y)begin
        if (x==y) z = 1'b1;
        else z = 1'b0;
    end
endmodule
//********