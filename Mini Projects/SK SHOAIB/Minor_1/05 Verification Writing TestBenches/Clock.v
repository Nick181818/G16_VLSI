`timescale 1ps/1ps
module top_module ( );
    
    reg clk;
    dut d1(clk);

    initial 
        begin 
            clk=1'b0;
        end 
    always #5 clk=~clk;
    

endmodule
