<i>

  # ASYNCHRONOUS FIFO
</i>
In this design all parts are desgin in different module. Here have two synchronizer module for write synchronizer and read synchronizer. one fifo module one top module one module for full condition and one empty condition. And the testbench is written in system verilog. and also in verilog


# <i> Design Specifications</i>:

* Transmitter A transmits data (burst of size 120), at 200MHz clock frequency.
* Receiver B receives the data at 50MHz clock frequency.
* No idle cycles between read and write are involved.

####  Input And Output Description
 |Signal |Description|
 |---|---|
 |wr_clk|Write clock|
 |rd_clk|Read clock|
 |wr_en|Write Enable|
 |rd_en|Read Enable|
 |wr_rst|Write Reset|
 |rd_rst|Read Reset|
 |wr_data|Write Data  to the FIFO Memory|
 |rd_data|Read Data from  the FIFO Memory|
 |o_fifo_full|This signal is "1" when FIFO is full|
 |o_fifo_empty|This signal is "1" when FIFO is empty| 

<i>
<b>

# CONTENTS
 * INTRODUCTION 

 * FIFO STRUCTURE

 * ARCHITECTURE

 * OPERATION

 * OUTPUT

 * SIMULATION WAVEFORM
</i>
</b>

<i>

  # INTRODUCTION
</i>

An asynchronous FIFO, short for First-In-First-Out, is a type of data buffer that allows data to be written into it at one rate and read from it at another rate. Unlike synchronous FIFOs, which rely on a common clock signal to synchronize data transfer between the read and write operations, asynchronous FIFOs operate without a common clock signal. Instead, they use handshaking signals, typically called "empty" and "full" to control data flow.

Asynchronous FIFOs are commonly used in digital systems where data is transferred between components operating at different clock frequencies or with independent timing domains. They provide a means of buffering data and synchronizing its transfer without requiring complex clock domain synchronization techniques.

The operation of an asynchronous FIFO involves careful consideration of timing constraints to ensure proper data integrity and prevent issues like data loss or corruption. These FIFOs typically employ techniques such as gray coding or two-phase handshaking to manage data transfers effectively in asynchronous environments.
  

<i>

  # FIFO STRUCTURE
</i>
<p align ="center">
<img src="https://github.com/GayazPatan/Images/assets/156210984/70ecbe19-27b3-4ff3-8df0-b89a986f331d" width="720px" height=auto />
</p>


<i>

  # ARCHITECTURE
</i>
The architecture of an asynchronous FIFO efficiently handles data transfer between devices with varying speeds or asynchronous timing. It includes components like data storage, pointers, control logic, handshaking signals, and status flags. These elements work together to buffer data, manage read and write operations, ensure synchronization, and maintain data integrity. The specific implementation varies based on system requirements and constraints.

<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/bc07e6fd-00cd-4fe3-be89-13fadd46e929" width="720px" height=auto />
</p>

<i>

# OPERATION
</i>
The steps involved in the operation of an asynchronous FIFO (First-In-First-Out) are as follows:
<i>

#### Write Operation:
</i>
<b> Data Input:</b> Data is written into the FIFO by the writing device (producer).<br/>
<b> Address Pointer Update: </b> The write address pointer increments to the next available storage location in the FIFO.</br>
<b> Handshaking: </b>If the FIFO is not full, handshaking signals (such as 'write enable') may be used to indicate that data is being written.

<i>

#### Read Operation:
</i>
<b>Data Output:</b> Data is read from the FIFO by the reading device (consumer).<br/>
<b>Address Pointer Update:</b> The read address pointer increments to the next available data location in the FIFO.</br>
<b>Handshaking: </b>If the FIFO is not empty, handshaking signals (such as 'read enable') may be used to indicate that data is being read.
<i>

#### Empty and Full Detection:
</i>

<b>

Empty Detection :</b> Empty detection involves checking whether the FIFO has any data available for reading. This is done by comparing the read and write pointers. If they are equal, the FIFO is empty.Some FIFO implementations may include a dedicated empty flag or status bit that indicates when the FIFO is empty.

<b>

Full Detection :</b> Full detection involves checking whether the FIFO has reached its maximum capacity and cannot accept any more data for writing.This is typically done by comparing the read and write pointers. If the write pointer catches up to the read pointer, the FIFO is full.Like empty detection, some FIFO implementations may include a dedicated full flag or status bit that indicates when the FIFO is full.

<p align ="center">
<img src="https://github.com/GayazPatan/Images/assets/156210984/bbcd98d4-fb48-4f03-883c-e7880318b5a5" width="720px" height=auto />
</p>


When the FIFO is detected as empty, appropriate action may be taken, such as preventing further read operations until new data is available. When the FIFO is detected as full, further write operations may be blocked until space becomes available in the FIFO.

Empty and full detection mechanisms ensure that data is managed effectively within the FIFO, preventing underflows and overflows while allowing for efficient data transfer between devices. These mechanisms are essential for the proper functioning of asynchronous FIFOs in digital systems.

<i>

  #### Data Transfer:
</i>
Data is transferred between the FIFO and the devices connected to it based on the handshaking signals and the status of the FIFO (empty or full).

<p align ="center">
<img src="https://github.com/GayazPatan/Images/assets/156210984/919d6a6d-0eca-4927-a4a4-89a76ffa7df5" width="720px" height=auto />
</p>

<i>

  #### Binary to Gray & Gray to Binary Conversion:
</i>
<b>Binary to Gray Code Converter:
</b>
Transforms binary numbers into Gray code, where adjacent values differ by only one bit.
Helps mitigate errors during asynchronous data transfer.
Implemented using logical XOR operations.
</br>
<b>
Gray Code to Binary Converter:
</b>
Converts Gray code back into binary format.
Allows processing of Gray code data received by the FIFO.
It involves logical XOR operations to decode Gray code inputs.
<p align ="center">
<img src="https://github.com/GayazPatan/Images/assets/156210984/38616ea1-a3ad-4e8a-a03c-6ef54339e24b" width="720px" height=auto />
</p>

<i>

#### FIFO Depth Calculation</i>
Frequency of Write clock = 200 MHz
Frequency of Read clock = 50 MHz
Burst Size = 120

Time period of Write clock = 5 nsec
Time period of Read clock = 20 nsec

Time to send a burst = 120*5 = 600 nsec
Number of data that can be read in 600 nsec  = 600/20 = 30

Number of bytes need to store in FIFO = 120 - 30 = 90</br>

<b>
  FIFO Depth = 90
</b>

<i>


  # OUTPUT
</i>
<p align ="center">
<img src="https://github.com/GayazPatan/Images/assets/156210984/af8f3954-9987-48a5-a67f-068cdfabf156" width="720px" height=auto />
</p>


<i>

  # SIMULATION WAVEFORM
</i>
Case 1:
After 90 Clock Cycle Fifo Full gets 1

<p align ="center">
<img src="https://github.com/GayazPatan/Images/assets/156210984/3d316121-fa61-4d9b-9794-7b2075bbcdc0" width="720px" height=auto />
</p>

case 2 :
Similarly after 90 Clcok Cycles Fifo Empty gets 1

<p align ="center">
<img src="https://github.com/GayazPatan/Images/assets/156210984/93a94178-2cd3-4ec9-a9ad-9407d4313d92" width="720px" height=auto />
</p>

Case 3 :
This section shows simultenous reading and writing of data as both the read and write enable signal goes high.

<p align ="center">
<img src="https://github.com/GayazPatan/Images/assets/156210984/514ccc6f-adeb-4b99-9505-bcf95f0813e2" width="720px" height=auto />
</p>
