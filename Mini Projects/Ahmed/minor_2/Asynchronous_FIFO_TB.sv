// 
// Testbench For Asynchrounous FIFO
//
`timescale 1us/1ps
module testbench();

    reg wr_clk, // Write clock signal
        rd_clk, // Read clock signal
        wr_rst, // Active high reset for the Write pointer
        rd_rst, // Active high reset for the Read pointer
        wr_en,  // Active high enable signal for write operation
        rd_en;  // Active high enable signal for write operation
    reg [7:0] wr_data;  // 8-bits input data from transmitter
    wire [7:0] rd_data; // 8-bits output data for receiver
    wire o_fifo_full,   //Signal for FIFO full
         o_fifo_empty;  //Signal for FIFO full

    // Instantiate the module under test
    Asynchronous_FIFO #() dut (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .wr_rst(wr_rst),
        .rd_rst(rd_rst),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .o_fifo_full(o_fifo_full),
        .o_fifo_empty(o_fifo_empty)
    );
  
   // Write clock generation
  initial begin
    wr_clk = 1'b1;
    forever #2.5 wr_clk = ~wr_clk; // Generating write clock of frequency 200 MHz
  end
  // Read clock generation
  initial begin
    rd_clk = 1'b1;
    forever #10 rd_clk = ~rd_clk; // Generating read clock of frequency 50 MHz
  end

  // Task: Continuous Write
  task write_task;
    begin
      repeat (90) begin
        wr_data = $random;
        wr_en = 1'b1; //Starting writing into FIFO
        #5;
      end
    end
  endtask

  // Task: Continuous Read
  task read_task;
    begin
      repeat (90) begin
        rd_en = 1'b1;
        wr_en = 1'b0;  // Disabling write operation
        #20;
      end
    end
  endtask

  // Task: Continuous Write and Read
  task write_read_task;
    begin
      repeat (100) begin
        wr_data = $random;
        wr_en = 1'b1;
        rd_en = 1'b1;
        #10;
      end
    end
  endtask

  // Testbench stimulus
  initial begin
    wr_rst = 1'b1;
    rd_rst = 1'b1;
    wr_en = 1'b0;
    rd_en = 1'b0;
    wr_data = 8'h00;

    // Reset signals
    #5 wr_rst = 1'b0;
    #5 rd_rst = 1'b0;

    // Calling tasks
    fork
      write_task();
      #550
      read_task();
      #2500
      write_read_task();
    join_none

    // Stop simulation after certain time
    #4000;
    $finish;
  end


  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end

endmodule