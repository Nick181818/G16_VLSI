# Asynchronous FIFO - Minor Project 2

## Problem Statement

Design an asynchronous FIFO with the following specifications.

### Design Specifications:
-	Transmitter A transmits data (burst of size 120), at 200MHz clock frequency
-	Receiver B receives the data at 50MHz clock frequency
-	No idle cycles between read and write are involved

### Write Interface:
-	wr_clk: write clock (200MHz)
-	wr_en: active high enable signal for the write operation to occur
-	wr_data: 8-bit data coming from the transmitter
-	wr_rst: active high reset signal to reset the write pointer involved, note, you do not reset the contents of the memory

### Read Interface:
-	rd_clk: read clock (50 MHz)
-	rd_en: active high enable signal for read operation to occur
-	rd_data: 8-bit data going to the receiver
-	rd_rst: active high reset signal to reset the read pointer involved

### FIFO Status Interface:
-	o_fifo_full: goes high when FIFO is full. No more data writes are possible in that case
-	o_fifo_empty: goes high when FIFO is empty. No more data reads are possible in that case 

### Reference Diagram

<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/30dad3de-996e-47a7-bad7-e995c79ed501" width="400">
</p>


### Design Details:

**Inputs and Output to FIFO**

|  Signal  |  Description                     |
|----------|----------------------------------|
|  wr_clk     | Clock signal for synchronization |
|  rd_clk     | Clock signal for synchronization  |
|  wr_rst     | Reset signal to bring the write pointer to idle state |
|  rd_rst     | Reset signal to bring the write pointer to idle state |
|  wr_en      | Write enable  |
|  rd_en      | Read enable  |
|  wr_data    | Signal used to write data to the memory |
|  rd_data    | Signal used to read data from the memory 
|  FIFO_full  | Signal used to indicate FIFO is full or not |
|  FIFO_empty | Signal used to indicate FIFO is empty or not |


### Assumed diagram

<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/022f1615-222e-4db4-bbf7-07aa845d82fa" width="400">
</p>

### Depth Calculation

<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/1453c257-237f-4566-b0f8-24f4180ab6c8" width="400">
</p>

### Assumed Architecture

<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/fabfb151-6ead-4608-9eb4-01de945e9f7a" width="400">
</p>


# Introduction To Asynchronous Fifo
- In asynchronous FIFO, data read and write operations use different clock frequencies. Since write and read clocks are not synchronized, it is referred to as asynchronous FIFO. Usually, these are used in systems where data need to pass from one clock domain to another which is generally termed as ‘clock domain crossing’. Thus, asynchronous FIFO helps to synchronize data flow between two systems working on different clocks.

<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/19bc71ee-c600-4f30-be68-a04f799ff27e" width="400">
</p>


## Operation:

- In the case of synchronous FIFO, the write and read pointers are generated on the same clock. However, in the case of asynchronous FIFO write pointer is aligned to the write clock domain whereas the read pointer is aligned to the read clock domain. Hence, it requires domain crossing to calculate FIFO full and empty conditions. This causes metastability in the actual design. In order to resolve this metastability, 2 flip flops or 3 flip flops synchronizer can be used to pass write and read pointers.

## Dual Flop Synchronizer:

<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/7c603e0a-7822-402d-a61d-19d4b5565179" width="400">
</p>



- When signals move from one clock domain to another, it may not be sampled correctly leading to unstable oscillations in the signal called metastability.

- Double Flop Synchronizer or Two flip-flop synchronizer is the simplest synchronization technique to ensure that the signal is sampled correctly at the destination domain.

- Metastability occurs when the setup/hold time of a flip-flop is violated and it leads to unstable oscillations.

- The oscillating signal from the source domain requires some time to settle down (setlling time) and this is what we provide by connecting an extra flip-flop working on the destination clock.

## Usage of Gray to Binary & Binary to Gray Converter:

- In an asynchronous FIFO, Gray to binary converters are used when data is read from the FIFO, converting Gray code data received from the asynchronous domain into binary data usable by the synchronous domain.

- Conversely, binary to Gray converters are used when data is written into the FIFO, converting binary data from the synchronous domain into Gray code data suitable for transmission across asynchronous clock domains.

- These converters help ensure proper synchronization and reliable data transfer between asynchronous clock domains while minimizing the risk of metastability and timing violations. 

# Waveforms
## Case - 1
<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/25bd74ff-d3a3-4ae0-b90b-76104a62aae2" width="800">
</p> 
<p align="center"><i>Figure -1</i></p>

- Figure - 1 represents the reading and writing operations in the FIFO memory based on the clock and enable signals of read and write respectively

## Case - 2
<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/ad2e0a85-b903-4abe-b713-9212bc983de1" width="800">
</p>
<p align="center"><i>Figure - 2</i></p>

<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/b9d0e041-8abb-4507-99a8-ec8788424979" width="800">
</p>
<p align="center"><i>Figure - 3</i></p>

- Figure - 2 and Figure - 3 represents the fifo_full signal oscillation due to simultaneous activation of read and write enable signals and as the fifo is full,we can't able to write the data into the memory which should be seen in Figure - 1

## Case - 3
<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/e943bbfb-7242-4c12-adf2-a593ab273ffb" width="800">
</p>

<p align="center"><i>Figure - 4</i></p>

- Figure - 4 represents the fifo empty and fifo full conditions and as the fifo_empty becomes high,we can't able to read the data as no data is present







