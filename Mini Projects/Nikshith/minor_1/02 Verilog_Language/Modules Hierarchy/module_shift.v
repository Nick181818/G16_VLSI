module top_module(input clk,input d,output q);  
    
wire out1,out2;
    my_dff instantiate1(clk,d,out1);   
    my_dff instantiate2(clk,out1,out2);   
    my_dff instantiate3(clk,out2,q);
    
endmodule