`timescale 1us/1ps
`timescale 1us/1ps
module Fifo_Top_tb();

  reg wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en;
  reg [7:0] wr_data;
  wire [7:0] rd_data;
    wire fifo_Full, fifo_Empty;

    // Instantiate the module under test
  asy_fifo #(8) dut (
    .wr_clk(wr_clk),
    .rd_clk(rd_clk),
    .wr_rst(wr_rst),
    .rd_rst(rd_rst),
    .wr_data(wr_data),
    .rd_data(rd_data),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .fifo_Full(fifo_Full),
    .fifo_Empty(fifo_Empty)
    );

    // Clock generation
  initial begin
    wr_clk = 1'b1;
    forever #2.5 wr_clk = ~wr_clk;
  end

  initial begin
    rd_clk = 1'b1;
    forever #10 rd_clk = ~rd_clk;
  end


    initial begin
       
        wr_rst = 1'b1;
        rd_rst = 1'b1;
        wr_en = 1'b0;
        rd_en = 1'b0;
        wr_data = 8'h00;

        #20;
        wr_rst = 1'b0;
        rd_rst = 1'b0;
        wr_en = 1'b1;
      
	  repeat (20) begin
      #20 wr_data = $random;
      wr_en = 1'b1;
    end
    end
  
  
    initial begin
    rd_rst = 1'b1;
    rd_en = 1'b0;
    // Reset
    #20 rd_rst = 1'b0;
      #20;

    // Write data to FIFO
    repeat (10) begin
      rd_en = 1'b1;
    end
    end
  
  	initial begin
      $monitor("wr_clk=0%d,wr_data=0%d,rd_clk=0%d,rd_data=0%d,fifo_Full=0%d,fifo_Empty=0%d",wr_clk,wr_data,rd_clk,rd_data,fifo_Full,fifo_Empty);
    end
    initial begin
        $dumpfile ("dump.vcd");
        $dumpvars ();
    end
	
	initial begin
        // Finish simulation
        #2000;
        $finish;
    end
endmodule