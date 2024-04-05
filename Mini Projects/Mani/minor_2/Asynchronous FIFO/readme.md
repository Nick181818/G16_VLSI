## Asynchronous_FIFO
This document explains about the design of an Asynchronous FIFO using the below given specifications:

- Design Specifications:

    - Transmitter A transmits data(burst of size=120),at clock frequency of 200MHZ.
    - Receiver B receives the data at 50 MHZ clock frequency.
    - No idle cycles between read and write are involved.

- Write interface:

    - wr_clk : write clock(200 MHZ)
    - wr_en : active high enable signal for the write operation to occur
    - wr_data : 8-bit data coming from the Transmitter
    - wr_rst : active high reset signal to reset the write pointer involved.

- Read interface:

    - rd_clk : read clock(50MHZ)
    - rd_en : active high enable signal for read operation to occur.
    - rd_data : 8-bit data going to the Receiver
    - rd_rst : active high reset signal to reset the read pointer involved.

- FIFO status interface:

    - o_fifo_full: goes high when FIFO is full.No more data writes are possible in that case.
    - o_fifo_empty: goes high when FIFO is empty.No more data reads are possible in that case.

## Introduction to Aynchronous FIFO

An Asynchronous FIFO is a circuit where the data values are written and read at different rates and at same time.As they work at different rates,we call them as "Asynchronous" i.e. the clocks are not syncronized.

    - The basic need for an Asynchronous FIFO arises when we are dealing with systems with different data rates.We use them to synchronise the data flow between the systems.

    - The main work of the circuit is to pass the data from one clock domain to another clock domain.

## Block diagram

<p align = "center">
  <img src="https://github.com/Maniteja-muriki/Image/assets/157959497/e42e896b-8b48-4daa-8bab-76153bcc13e2" width="720px" Height="auto">
</p>

## Directory structure
 
-> FIFOmodule.v
-> writedata.v
-> readdata.v
-> binarytogrey.v
-> greytobinary.v
-> outputstatus.v
-> readme.md

    - **FIFOmodule.v**- This file defines the topmodule of FIFO
    - **writedata.v**- This file has the code for writing data into write pointer
    - **readdata.v**- This file has the code for reading data from the read pointer
    - **binarytogrey.v**- This file has the code of conversion of binary code data into grey data
    - **greytobinary.v**- This file has the code of conversion of grey code data into binary code 
    - **outputstatus.v**- This file states the conditions for FIFO full and FIFO empty
    - **readme.md**- This file contains the theoretical details about Asynchronous FIFO

   ## FIFO depth calculation

   - write frequency(fw)=200MHZ
   - read frequency(fr)=50MHZ
   - Burstsize=120
   - Time taken to write one data item=1/fw =1/200MHZ = 5ns
   - The total time for writing fulldata=Burstsize x 5ns = 120 x 5ns =600ns
   - Time taken to read one data item =1/fr =1/50MHZ = 20ns
   - Divide 600ns by 20ns = 30
   - FIFO DEPTH= Burstsize -30 = 120-30= 90