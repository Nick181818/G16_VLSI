README - Asynchronous FIFO Design

Design Specifications:

Transmitter A transmits data (burst=120) at a 200MHz clock frequency.
Receiver B receives the data at a 50MHz clock frequency.
No idle cycles between read and write operations.
Write Interface:

wr_clk: Write clock (200MHz)
wr_en: Active high enable signal for the write operation.
wr_data: 8-bit data from the transmitter.
wr_rst: Active high reset signal to reset the write pointer (does not reset memory contents).
Read Interface:

rd_clk: Read clock (50 MHz)
rd_en: Active high enable signal for read operation.
rd_data: 8-bit data going to the receiver.
rd_rst: Active high reset signal to reset the read pointer.
FIFO Status Interface:

o_fifo_full: Goes high when FIFO is full.
o_fifo_empty: Goes high when FIFO is empty.
Asynchronous FIFO Pointers:

Write Pointer:

Points to the next word to be written. On reset, both pointers set to zero.
Read Pointer:

Points to the current FIFO word to be read.
Synchronizers:

Comprising 2 D Flip Flops to synchronize Write and Read pointers for generating empty and full logic.
Binary Gray Counter:

Designed to provide Binary and Gray outputs.
Binary counter used to address the FIFO MEMORY for Write and Read addresses.
Gray counter used for addressing Read and Write pointers.
Design Implementation:

<p align = "chttps://github.com/Nick181818/fifo/assets/122737277/c4d781bd-1e61-47ba-ae4b-c1cc648945d9">
  <img src="" width="720px" Height="auto">
</p>

Inputs:

wr_clk, rd_clk, wr_en, rd_en, wr_rst, rd_rst, wr_data are inputs of the synchronous FIFO.
Outputs:

rd_data, fifo_Full, fifo_Empty are output ports of the asynchronous FIFO.
Memory:

wr_ptr, rd_ptr are 8-bit pointers.
Memory size: 90 depth & 8 width.
Logic for wrptr:

fifo_Full condition: (wr_ptr[7] != rd_ptr[7]) & (wr_ptr[6:0] == rd_ptr[6:0])
Logic for rdptr:

fifo_Empty condition: (wr_ptr[7] == rd_ptr[7]) & (wr_ptr[6:0] == rd_ptr[6:0])
Additional Notes:

Synchronization is not applied to the logic for wrptr and rdptr.

Conclusion:
This document outlines the design specifications and implementation details of an asynchronous FIFO, including its interfaces, pointers, synchronizers, and logic for pointer control without synchronization.
