module testbench();

    reg wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en;
  reg [7:0] wr_data;
  wire [7:0] rd_data;
  wire o_fifo_full;
  wire o_fifo_empty;

    // Instantiate the module under test
    ASYNC_FIFO#() dut (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .wr_rst(wr_rst),
        .rd_rst(rd_rst),
        .wr_data(wr_data),
        .rd_data(rd_data),
     	.wr_en( wr_en),
        .rd_en(rd_en),
        .o_fifo_full(o_fifo_full),
        .o_fifo_empty(o_fifo_empty)
    );
  
   // Clock generation
  initial begin
    wr_clk = 1'b1;
    forever #2.5 wr_clk = ~wr_clk;
  end
  // Clock generation
  initial begin
    rd_clk = 1'b1;
    forever #10 rd_clk = ~rd_clk;
  end

  // Task: Continuous Write
  task write_task;
    begin
      repeat (120) begin
        wr_data = $random;
        wr_en = 1'b1;
        #10;
      end
    end
  endtask

  // Task: Continuous Read
  task read_task;
    begin
      repeat (120) begin
        rd_en = 1'b1;
        wr_en = 1'b0;
        #30;
      end
    end
  endtask

  // Task: Continuous Write and Read
  task write_read_task;
    begin
      repeat (150) begin
        wr_data = $random;
        wr_en = 1'b1;
        rd_en = 1'b1;
        #5;
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

    // Reset
    #7 wr_rst = 1'b0;
    #10 rd_rst = 1'b0;

    // Spawn tasks
    fork
      write_task();
      #50
      read_task();
      #500
      write_read_task();
    join_none

    // Stop simulation after certain time
    #2000;
    $finish;
  end
initial begin
      $monitor("wr_clk=0%d,wr_data=0%d,rd_clk=0%d,rd_data=0%d,o_fifo_full=0%d,o_fifo_empty=0%d",wr_clk,wr_data,rd_clk,rd_data,o_fifo_full,o_fifo_empty);
    end


  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end

endmodule