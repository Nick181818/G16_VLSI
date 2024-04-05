# **Asynchronous FIFO**
in this design all parts are desgin in different module. Here have two sunchronizer module for wrt synchronizer and read synchroniser. one fifo module one top module one module for full condition and one empty condition.
And the testbench is written in system verilog.
and also in verilog

# _Contents_

 + Introduction 

 + FIFO structure

 + Architecture

 + Asynchronous FIFO Pointers

 + Synchronizers & Binary Gray Counter

 + Full & Empty Logic Block

 + Outputs and Simulation



 ## _Design Specifications_

 * _Given Input and Output Clock Signlas:_
    - Transmitter A transmits data (burst of size 120), at 200MHz clock frequency.
    - Receiver B receives the data at 50MHz clock frequency.
    - No idle cycles between read and write are involved.

  ## _FIFO Depth Calculation_

  * Frequency of Write clock = 200 MHz
     - Frequency of Read clock = 50 MHz
     - Burst Size = 120

     - Time period of Write clock = 5 nsec
     - Time period of Read clock = 20 nsec

     - Time to send a burst = 120*5 = 600 nsec
     - Number of data that can be read in 600 nsec  = 600/20 = 30

     - Number of bytes need to store in FIFO = 120 - 30 = 90

     - FIFO Depth = 90

 ## _Write interface:_
  * Write Pointer
    - wr_clk : write clock (200MHz)
    - wr_en: active high enable signal for the write operation to occur
    - wr_data: 8-bit data coming from the transmitter
    - wr_rst: active high reset signal to reset the write pointer involved, note, you do not reset the contents of the memory.

 ## _Read interface:_
  * Read Pointer
    - rd_clk: read clock (50 MHz)
    - rd_en: active high enable signal for read operation to occur
    - rd_data: 8-bit data going to the receiver
    - rd_rst: active high reset signal to reset the read pointer involved.

## _FIFO status interface:_
 * Fifo Empty and Full
    - o_fifo_full: goes high when FIFO is full. No more data writes are possible in that case.
    - o_fifo_empty: goes high when FIFO is empty. No more data reads are possible in that case.

  ####  Input And Output Description

 |Signal |Description|
 |---|---|
 |wr_clk|Write clock|
 |rd_clk|Read clock|
 |wr_en|Write Enable|
 |rd_en|Read Enable|
 |wr_rst|Write Reset|
 |rd_rst|Read Reset|
 |wr_data|Write Data Input to the FIFO|
 |rd_data|Read Data Output to the FIFO|
 |o_fifo_full|This signal is "1" when FIFO is full|
 |o_fifo_empty|This signal is "1" when FIFO is empty| 

### Files in this Submissions
```
├── Async_FIFO.vcd
├── Binary2Gray.v
├── Dual_flop_sync.v
├── Fifo_Memory.v
├── Fifo_Top_Module.v
├── Fifo_Top_tb.v
├── Gray2Binary.v
├── read_Unit.v
├── Readme.md
└── write_Unit.v
```

# *Introduction*
FIFO-Every memory in which the data word that is written in first also comes out first when the memory is read is a first-in first-out memory.

An asynchronous FIFO refers to a FIFO design where data values are written sequentially into a FIFO buffer using one clock domain, and the data values are sequentially read from the same FIFO buffer using another clock domain, where the two clock domains are asynchronous to each other. 

One common technique for designing an asynchronous FIFO is to use Gray code pointers that are synchronized into the opposite clock domain before generating synchronous FIFO full or empty status signals.
  
# FIFO Structure
<p align = "center">
  <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/9800e2ff-7a08-49a9-b2a2-7791a72a6817" width="720px" Height="auto">
</p>

# Architecture

<p align = "center">
  <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/7440b741-fe06-4e1e-850d-fef906336026" width="720px" Height="auto">
</p>


## Schematic Diagram

<p align = "center">
  <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/c0d81b0a-4c21-4e7e-a9cf-3fc11f0ec3e4" width="720px" height="auto">
</p>

# Asynchronous FIFO Pointers

### Write Unit:

The write pointer always points to the next word to be written; therefore, on reset, both pointers are set to zero, which also happens to be the next FIFO word location to be written.

<p align = "center">
  <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/aaba887b-0fa3-4552-b86f-5f31c98b98c5" width="720px" height="auto">
</p>

### Read Unit:

The read pointer always points to the current FIFO word to be read. The fact that the read pointer is always pointing to the next FIFO word to be read means that the receiver logic does not have to use two clock periods to read the data word.

<p align = "center">
  <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/d9747c71-4292-4e97-9ef1-10c6657df04e" width="720px" height="auto">
</p>

#  Dual Flop Synchronizers

Synchronizers are very simple in operation; they are made of 2 D Flip Flop’s.As the FIFO is operating at 2 different clock domains so there is a need to synchronize the Write and Read pointers for generating empty and full logic which in turn is used for addressing the FIFO memory.

The Figure below shows how synchronization takes place; the logic behind this is very simple,

### Synchroniser using two flip flop

<p align = "center">
  <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/eddbec3b-f977-45f9-9581-0bb9f9bb319f" width="720px" Height="auto">
</p>
   

_We need to design a counter which can give Binary and Gray output’s, the need for Binary counter is to address the FIFO MEMORY i.e. Write and Read address. And the need of Gray counter is for addressing Read and Write pointers._

### Binary to Gray Convertor
A Binary to Gray code converter is a logical circuit that is used to convert the binary code into its equivalent Gray code.

<p align="center">
  <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/18768247-fc5d-4811-b444-bfae3d04c471" width="720px" height="auto">
</p>

### Gray to Binary Converter
A Gray to Binary Converter is a logical circuit that is used to convert the Gray code into its equivalent binary code.

<p align="center">
  <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/be2099f7-f972-4e46-99ee-2078f414cc07" width="720px" height="auto">
</p>

# Full & Empty Logic Block

When the status counter reaches the maximum FIFO depth it will assert FIFO full signal and when its value is zero it will assert FIFO empty signal

<p align = "center">
  <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/f5a0694f-4655-4f40-8ed7-156d0ac791c8" width="720px" Height="auto">
</p>

# OUTPUTS------

<p align = "center">
  <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/96037a94-d03d-4dbd-8216-e89114bb2428" width="720px" Height="auto">
</p>

## Simulation Waveform-------

<p align="center">
  <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/3b71ec66-688e-459e-887d-99ec47e182f6" width="720px" heigth="auto">
</p>

**Explanation:**
- Section 1 : Write Operation
- Section 2 : Read Operation
- Section 3 : Both Read and Write Operation

### Section 1

##### Case 1:

**_After 90 Clock Cycle Fifo Full gets 1_**

<p align="center">
  <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/4b3d6368-73ed-4374-abd1-1c5b75f3cafd" width = "720px" heigth = "auto">
</p>

### Section 2
 
 #### case 2 :

**_Similarly after 90 Clcok Cycles Fifo Empty gets 1_**

<p align="center">
  <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/f5f9219e-d672-49fc-92e9-2378d7c03c01" width = "720px" heigth = "auto">
</p>

### Section 3
This section shows simultenous reading and writing of data as both the read and write enable signal goes high.
<p align="center">
  <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/d94ba044-483c-40a9-9531-21db68f78cef" width = "720px" heigth = "auto">
</p>
