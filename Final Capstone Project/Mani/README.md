# STRV32I

Interface Details:

- General Interface:
    - a)clk_in: System clock(10MHZ).
    - b)rst_in: Active high and synchronous system reset.

- Instruction Cache Interface
    - a)imaddr_out: Carries 32-bit target address to icache
    - b)instr_in : 32-bit instruction fetched from icache

- Data Cache Interface
    - a)dmwr_req_out: Write request signal to dcache,when high indicates a write request to dcache while being low it indicates a read request.This is a single bit signal.
    - b)dmaddr_out : Carries the 32-bit target(read/write) address to dcache.
    - c)dmdata_in : This is the 32-bit data read from dcache.During the "Load".
    - d)dmdata_out : This is the 32-bit to be written to dcache.During the "Store".
    - e)dmwr_mask_out : This is a 4-bit mask signal that decides the bits to be masked during the dcache write operation.

   
  
 ## Introduction

 - RISC Processor 
    - RISC stands for Reduced Instruction Set Computer. In Reduced Instruction Set Computer (RISC) architecture, the instruction set of the computer is simplified to reduce the execution time. RISC has a small set of instructions, which generally include register-to-register operations.

    - Thus, data is stored in processor registers for computations, and results of the computations are transferred to the memory using store instructions. All operations are performed within the registers of the CPU. In RISC, all instructions have simple register addressing and hence use less number of addressing modes.

    - The RISC processors can execute one instruction per clock cycle.

    - This is done using pipelining, which involves overlapping the fetch, decode, and execute phases of two or three instructions. As RISC takes relatively a large number of registers in the processor unit, it takes less time to execute its program when compared to CISC.

## Architecture of RISC-V processor

<p align="center">
 <img
src=https://github.com/Maniteja-muriki/Image/issues/3#issue-2223266124
width="720px" Height="auto">
</p>

The proposed processor will complete all the five steps namely "Instruction Fetch","Instruction Decode","Execution","Memory Access","Write back" in 3 stages(3 clock cycles)

- Stage 1 :- Instruction Fetch
- Stage 2 :- Instruction Decode
- stage 3 :- Execution,Memory access and Writeback.

## Building Blocks of the Processor

- 1.PC Unit:-
This block is responsible for retrieving the next instruction from the instruction memory. The Program Counter (PC) points to the current instruction, and after fetching, the PC is updated to the next instruction address.


- 2.Decoder:-
 The fetched instruction is decoded to understand the operation to be performed. This involves identifying the operation code (opcode), source operands, destination register, and any immediate values.

 - 3.Register file:-
  The fetched instruction is decoded to understand the operation to be performed. This involves identifying the operation code (opcode), source operands, destination register, and any immediate values.

 - 4.Dcache:-
 A data cache is used to store frequently accessed data.

 - 5.Icache:-
 The instruction cache stores frequently accessed instructions to reduce the time taken to fetch them.

 - 6.ALU unit:-
 This block executes the instruction. Arithmetic and logical operations are performed here. If the instruction is a branch, the EX block evaluates the branch condition and calculates the new PC value if needed.

 <p align="center">
  <img
  src="https://github.com/Maniteja-muriki/Image/issues/2"
  width="720px"Height="auto">
  </p>

 - 7.Writeback Mux:-
  The results of the execution, or the data read from memory, are written back to the register file in this stage.

  - 8.Immediate generator:-
  Based on the instruction type,extracts immediate data from instruction[31:7] and generates 32-bit immediate value after sign extension.

  - 9.Immediate adder:-
  It takes the PC_in and adds it with the immediate value produced by the immediate generator and hence successfully generates new value of PC.
 <p align="center">
  <img
  src="https://github.com/Maniteja-muriki/Image/issues/5#issue-2228301165"
  width="720px"Height="auto">
  </p>

 
  - 10.Write enable generator:-
  It generates the write enable signals,which will decide whether we can access the register file for writing/updating any value.
 <p align="center">
  <img
  src="https://github.com/Maniteja-muriki/Image/issues/8#issue-2228455344"
  width="720px"Height="auto">
  </p>
   
  - 11.Control Unit:-
 It has two states- Reset and Operation.If Reset=0,Controlunit operates in Operation mode and when Reset=1,it will be in reset state.
    - It flushes out the PC value in case of branch and jump instructions.

  - 12.Load Unit:-
  The load unit reads the data_in input signal and forms a 32-bit value based on the load_size_in.
    - Load_size_in tells whether the number will be byte,half-word or word and iadder_out_1_0_in tells at what position it will be placed in output.

  - 13.Store Unit:-
  The Store Unit drives the signals that interface with external data memory.
    - It places the data to be written in the right position in data_out and sets the  value of wr_mask_out in an appropriate way depending on func3_in value.
    - Then it puts the data back into D-cache depending on value of mem_wr_req_in.

  - 14.Instruction Mux :-
 This module takes the instruction and provides the fields which are used by the other modules to perform their functionality.
    - The "flush" input will give the address 32'h 0000_0000 to all the fields when high else follows as per ISA(core instruction given) when low.

  - 15.Branch unit :-
Branch conditions are conditional jumps.It will decide if a branch instruction must be taken or not.
    - It receives two operands from the Integer Register File,and based on the value of opcode and func3_in instruction fields,it decides the branch i.e. value of branch_out.
 <p align = "center">
  <img src="https://github.com/Maniteja-muriki/Image/issues/4#issue-2228274550" width="720px" Height="auto">
</p>

  - 16.Register block 1:-
  It is an array of D-Flipflops used for synchronisation purpose so that all the signals of stage1 pass through it so that they are able to reach 2nd stage in 2nd clock cycle.
 <p align="center">
  <img
  src="https://github.com/Maniteja-muriki/Image/issues/6#issue-2228452418"
  width="720px"Height="auto">
  </p>
  - 17.Register block 2:-
  It registers all the inputs and produces the outputs at the posedge of clock,if there is no reset,so that the signals of stage 2 can't reach stage 3 before 3rd clock cycle.
   - The block also integrates a 2:1 MUX with select-line as branch_taken_in.The LSB of iadder_out_reg is assigned with 0 if branch_taken_in is 1,else it is assigned with the registered value of iadder_in. 
 <p align="center">
  <img
  src="https://github.com/Maniteja-muriki/Image/issues/7#issue-2228453362"
  width="720px"Height="auto">
  </p>