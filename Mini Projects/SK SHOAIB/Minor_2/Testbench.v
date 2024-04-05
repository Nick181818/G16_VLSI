`timescale 1us/1ps

module testbench();

    reg wrclk; 
    reg rdclk; 
    reg wrrst; 
    reg rdrst; 
    reg wren;
    reg rden;  
    reg [7:0] d_in; 
    wire [7:0] d_out; 
    wire fifo_full;   
    wire fifo_empty;  

    // Instantiate the module under test
    asynchronous_fifo #() dut (
        .wrclk(wrclk),
        .rdclk(rdclk),
        .wrrst(wrrst),
        .rdrst(rdrst),
        .d_in(d_in),
        .d_out(d_out),
        .wren(wren),
        .rden(rden),
      .fifo_full(fifo_full),
        .fifo_empty(fifo_empty)
    );
  
   // Write clock generation
  initial begin
    wrclk = 1'b1;
    forever #2.5 wrclk = ~wrclk; 
  end
  // Read clock generation
  initial begin
    rdclk = 1'b1;
    forever #10 rdclk = ~rdclk; 
  end

  // Task: Continuous Write
  task write_task;
    begin
      repeat (100) begin
        d_in = $random;
        wren = 1'b1; //Starting writing into FIFO
        #5;
      end
    end
  endtask

  // Task: Continuous Read
  task read_task;
    begin
      repeat (100) begin
        rden = 1'b1;
        wren = 1'b0;  // Disabling write operation
        #20;
      end
    end
  endtask

  // Task: Continuous Write and Read
  task write_read_task;
    begin
      repeat (150) begin
        d_in = $random;
        wren = 1'b1;
        rden = 1'b1;
        #10;
      end
    end
  endtask

  // Testbench stimulus
  initial begin
    wrrst = 1'b1;
    rdrst = 1'b1;
    wren = 1'b0;
    rden = 1'b0;
    d_in = 8'h0F;

    // Reset signals
    #5 wrrst = 1'b0;
    #5 rdrst = 1'b0;

    // Calling tasks
    fork
      write_task();
      #500
      read_task();
      #2000
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
