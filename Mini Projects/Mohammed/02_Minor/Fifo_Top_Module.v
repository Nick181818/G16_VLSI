`include "Fifo_Memory.v"
`include "write_Unit.v"
`include "read_Unit.v"
`include "Gray2Binary.v"
`include "Dual_flop_sync.v"
`include "Binary2Gray.v"


module Fifo_Top_Module 
    #(
        parameter S = 8 //Set The Width
        )
(
    input wr_clk, //Write Clock  
    input rd_clk, //Read Clock  
    input wr_rst, //Write Reset  
    input rd_rst, //Read Reset  
    input wr_en, //Write Enable  
    input rd_en, //Read Enable  
    input [7:0] wr_data, //Write Data Given 8 bits Address  
    output [7:0] rd_data, //Read Data Given 8 bits Address  
    output o_fifo_full, //Fifo Full 1 bit Address  
    output o_fifo_empty //Fifo Empty 1 bit Address  
);

//Declaration Of Wires  
wire wr_EnDer;  //Enable  
wire [S-1:0] wr_ptr; //Write Pointer  
wire [S-1:0] wr_ptrB2G; //Write Pointer Binary to Gray  
wire [S-1:0] rd_ptrDualFlopSyncOut; //Read Pointer Flop Synchronizer Out  
wire [S-1:0] rd_ptr; //Read Pointer  
wire [S-1:0] wr_ptrG2B; //Write Pointer Gray to Binary  
wire [S-1:0] wr_ptrDualFlopSyncOut; //Write Pointer Flop Synchronizer Out  
wire [S-1:0] rd_ptrB2G; //Read Pointer Binary to Gray  
wire [S-1:0] rd_ptrG2B; //Read Pointer Gray to Binary  

//Instantiate the Fifo Memory Module  
Fifo_Memory uutFifo_Memory 
(
    .wr_clk(wr_clk),
    .rd_clk(rd_clk),
    .rd_en(rd_en),
    .wr_ptr(wr_ptr),
    .rd_ptr(rd_ptr),
    .wr_en(wr_EnDer),
    .wr_data(wr_data),
    .rd_data(rd_data)
);

//Assign the Value of Enable  
assign wr_EnDer = wr_en & ~o_fifo_full;

//Instantiate the Write Unit  
write_Unit uutwrite_Unit
(
    .wr_clk(wr_clk),
    .wr_en(wr_en),
    .wr_rst(wr_rst),
    .rd_ptr(rd_ptrG2B),
    .wr_ptr(wr_ptr),
    .fifo_full(o_fifo_full)
);

//Insatntiate the Read Unit  
read_Unit uutread_Unit
(
    .rd_clk(rd_clk),
    .rd_en(rd_en),
    .rd_rst(rd_rst),
    .wr_ptr(wr_ptrG2B),
    .rd_ptr(rd_ptr),
    .fifo_empty(o_fifo_empty)      
);

//Instantiate Binary to Gray Write  
Binary2Gray uutBinary2GrayWrite 
(
    .bin_in(wr_ptr),
    .gray_out(wr_ptrB2G)
);

//Instantiate Flop Synchronizer Write  
Dual_flop_sync uutDual_flop_syncWrite
(
    .data_in(wr_ptrB2G),
    .data_out(wr_ptrDualFlopSyncOut),
    .clk(rd_clk),
    .rst(rd_rst)
);

//Instantiate Gray to Binary Write  
Gray2Binary uutGray2BinaryWrite
(
    .gray_in(wr_ptrDualFlopSyncOut),
    .bin_out(wr_ptrG2B)
);

//Instantiate Binary to Gray Read  
Binary2Gray uutBinary2GrayRead 
(
    .bin_in(rd_ptr),
    .gray_out(rd_ptrB2G)
);

//Instantiate Flop Synchronizer Read  
Dual_flop_sync uutDual_flop_syncRead
(
    .data_in(rd_ptrB2G),
    .data_out(rd_ptrDualFlopSyncOut),
    .clk(wr_clk),
    .rst(wr_rst)
);

//Instantiate Gray to Binary Read
Gray2Binary uutGray2BinaryRead
(
    .gray_in(rd_ptrDualFlopSyncOut),
    .bin_out(rd_ptrG2B)
);

endmodule