# **Final Capstone Project Riscv-32I**

  ## **Sure Trust RiscV-32I</b>**

   + $STRV32I$ $is$ $actually$ $a$ $RISC-V$
   + $RISC-V$ $32$ $refers$ $to$ $the$ $32-bit$ $version$ $of$ $the$ $RISC-V$ $instruction$ $set$ $architecture$ [ISA](https://riscv.org/wp-content/uploads/2019/12/riscv-spec-20191213.pdf)
   + $Like$ $its$ $64-bit$ $counterpart$, $RISC-V$ $32$ $is$ $based$ $on$ $the$ $principles$ $of$ $Reduced$ $Instruction$ $Set$ $Computing$ $(RISC).$
   + $RISC-V$ $32$ $is$ $a$ $version$ $of$ $the$ $RISC-V$ $instruction$ $set$ $architecture$ $that$ $operates$ $with$ $32-bit$ $data$ $and$ $addresses.$

   + $It$  $prioritizes$ $simplicity$ $and$ $efficiency$ $in$ $processor$ $design.$ $RISC-V$ $32$, $like$ $its$ $64-bit$ $counterpart$, $is$ $modular$, $open-source$, $and$ $allows$ $for$ $optional$ $extensions$ $to$ $support$ $specific$ $functionalities.$ 
   + $It's$ $suitable$ $for$ $a$ $wide$ $range$ $of$ $applications$, $from$ $embedded$ $systems$ $to$ $smartphones$, $offering$ $versatility$ $and$ $flexibility.$

  

  ## **CONTENTS**

  - [x] DESIGN SPECIFICATIONS
  - [x] Deliverables
  - [x] FILES IN THIS SUBMISSION
  - [x] INTRODUCTION
  - [x] STRV32I STRCUTURE
  - [x] OPERATION
  - [x] INSTRUCTIONS WITH OUTPUT WAVEFORMS

  ## **DESIGN SPECIFICATIONS**

   $Design$ $a$ $3-stage$ $pipelined$ $RISC-V$ $processor$ $that$ $works$ $on$ $RV32I$ [ISA](https://riscv.org/wp-content/uploads/2019/12/riscv-spec-20191213.pdf)

1. ***Interface:***

  - 	clk_in: System clock.

  - 	rst_in: Active high and synchronous system reset.

2. ***Instruction Cache Interface:***

  - 	imaddr_out: Carries 32-bit target address to icache.

  - 	instr_in: 32-bit instruction fetched from icache.

3. ***Data Cache Interface:***

  - 	dmwr_req_out: Write request signal to dcache, when high indicates a write request to dcache while being low it indicates a read request. This is a single bit signal.

  - 	dmaddr_out: Carries the 32-bit target(read/write) address to dcache.

  - 	dmdata_in: This is the 32-bit data read from dcache. During the Load.

  - 	dmdata_out: This is the 32-bit data to be written to dcache. During the Store.

  - 	dmwr_mask_out: This is a 4-bit mask signal that decides the bits to be masked during the dcache write operation.


  ####  $Input$ $And$ $Output$ $Description$
  |Port name |Direction|Type|Description|
  |---|---|---|---|
  |`clk_in`|input| |System Clock|
  |`rst_in`|input| |System Reset|
  |`dmdata_in`|input| [31:0]| Data input from dcache|
  |`instr_in`|input| [31:0]|Instruction input from icache|
  |`dmwr_req_out`|output| |Write request to dcache|
  |`imaddr_out`|output| [31:0]|Address output to icache|
  |`dmaddr_out`|output| [31:0]|Address output to dcache|
  |`dmwr_mask_out`|output | [3:0]| Mask bits to dcache|
  |`dmdata_out`|output| [31:0]|Data output to dcache|


  ##  **Deliverables**

  + ***Performance Analysis:***

      + Clock cycle count, throughput, and latency for various instructions and instruction sequences.

  + ***Pipeline Diagram:***

    + Illustration of pipeline stages and instruction flow.

   + ***Hazard Detection and Resolution:***
    
      + Explanation of data hazards, control hazards, and structural hazards detection and mitigation.

  + ***Memory Subsystem:***
    
    + Description of memory access handling, including memory hierarchy and cache structure.

  + ***Forwarding and Stall Mechanisms:***
    
    +  Description of data forwarding and stall mechanisms for maintaining correct instruction execution.

  + ***Exception Handling:***
  
    + Explanation of how exceptions, interrupts, traps, and system calls are handled.

  + ***Verification Plan:***
  
    + Methodology and tools used for verifying the correctness of the processor design.



  ## **FILES IN THIS SUBMISSIONS**

```
├── alu_unit.v
├── branch_unit.v
├── control_unit.v
├── decoder.v
├── immediate_adder.v
├── immediate_generator.v
├── load_unit.v
├── pc_unit.v
├── Readme.md
├── reg_block_1.v
├── reg_block_2.v
├── reg_file.v
├── Riscv_Top.v
├── Riscv_tb.v
├── store_unit.v
├── WB_mux_selection_unit.v
├── wr_en_gen.v
└── Instr_File.mem
```

     
  - **[Readme.md](https://github.com/touheed1829/G16_VLSI/blob/main/Final%20Capstone%20Project/Mohammed/README.md)** - This is a markdown file which contains all the report of project.
  - **[Riscv_Top.v](https://github.com/touheed1829/G16_VLSI/tree/main/Final%20Capstone%20Project/Mohammed/RTL_src/Riscv_Top)** - This is the Top Module and it contains all the Instantiations of 
      - `alu_unit.v`
      - `branch_unit.v` 
      - `control_unit.v`
      - `decoder.v`
      - `immediate_adder.v`
      - `immediate_generator.v`
      - `load_unit.v`
      - `pc_unit.v`
      - `reg_block_1.v`
      - `reg_block_2.v`
      - `reg_file.v`
      - `store_unit.v`
      - `WB_mux_selection_unit.v`
      - `wr_en_gen.v`
  - **[Riscv_tb.v](https://github.com/touheed1829/G16_VLSI/tree/main/Final%20Capstone%20Project/Mohammed/RTL_src/Riscv_Test_Bench)** - This is a test bench file recquired to play along the input values.
   - **[Instr_src](https://github.com/touheed1829/G16_VLSI/tree/main/Final%20Capstone%20Project/Mohammed/RTL_src/Instruction_src)** - This is an Instruction File which has instruction operations to do while executing a program.

  ## **INTRODUCTION**
    
  Computers are built on specific architectural designs that dictate how instructions are executed and processed. Two primary architectures exist: Complex Instruction Set Computer (CISC) and Reduced Instruction Set Computer (RISC).

***RISC (Reduced Instruction Set Computer)***
RISC architecture, on the contrary, focuses on a reduced set of simple instructions, each typically executed in a single clock cycle. This simplicity results in faster execution and improved performance.
RISC architectures prioritize efficiency by favoring a smaller set of instructions, emphasizing faster instruction execution, and enabling better pipelining and parallelism. Notable RISC architectures include ARM and MIPS.

RISC-V stands as a cutting-edge open-source instruction set architecture (ISA) that embodies simplicity, adaptability, and versatility. Developed at the University of California, Berkeley, the RISC-V ISA was introduced in 2010 as an academic project aiming to address the limitations of existing architectures and provide a platform for innovation in computer architecture.

#### Block Diagram

<p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/baa5520d-67a2-4878-abac-f81363cc4e44" width="720px" height=auto />
</p>

 #### <b>RISC architecture consists of a series of stages that an instruction goes through during its execution:</b>
1. ***Instruction Fetch***:
	 - The CPU fetches the instruction from memory.
2. ***Decode***:
	 -  The instruction is decoded to determine the operation to be performed.
3. ***Execute***:
	 - The CPU executes the operation specified by the instruction.
4. ***Memory Access***:
	 - If necessary, the CPU accesses memory to read or write data.
5. ***Write Back***:
	 - The CPU writes the results of the operation back to the appropriate register or memory location.

> [!IMPORTANT]
> **Why RISCV?**

> $RISC$ $architecture$, $on$ $the$ $contrary$, $focuses$ $on$ $a$ $reduced$ $set$ $of$ $simple$ $instructions$, $each$ $typically$ $executed$ $in$ $a$ $single$ $clock$ $cycle.$
> $This$ $simplicity$ $results$ $in$ $faster$ $execution$ $and$ $improved$ $performance.$
> $RISC$ $architectures$ $prioritize$ $efficiency$ $by$ $favoring$ $a$ $smaller$ $set$ $of$ $instructions$, $emphasizing$ $faster$ $instruction$ $execution$, $and$ $enabling$ $better$ $pipelining$ $and$ $parallelism$.$
  
> [!Note] 
> $RISC$ $architectures$ $include$ $ARM$ $and$ $MIPS.$


##	<b>Advantages of RISC-V</b>
RISC-V stands as a beacon in modern computing due to its revolutionary features and adaptable nature, encompassing several advantages:

- ***Openness and Accessibility***:
  - RISC-V's open-source nature democratizes access to the ISA, enabling innovation without licensing fees or restrictions.

- ***Flexibility and Customizability***:
   - The modular design allows users to tailor solutions by incorporating custom instructions or extensions, fostering adaptability across diverse applications.

- ***Scalability and Versatility***:
   - Supporting various versions like RV32I, RV64I, and RV128I, RISC-V addresses different performance needs and computing environments.

- ***Elegance and Simplicity***:
   - RISC-V's streamlined design emphasizes a reduced instruction set, enhancing predictability, ease of implementation, and efficiency.
	
- ***High Extensibility***:
   - A pivotal feature of RISC-V is its exceptional extensibility. This attribute enables users to expand the instruction set architecture by incorporating custom instructions or entire extensions. Its extensibility allows for the addition of new features, optimizations, and specialized functionalities, ensuring adaptability to evolving technological requirements and computing paradigms.

 

# <b>STRV32I STRCUTURE</b>

<p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/8b31b2d9-6fcc-438c-98ba-8d8fbfaded9e" width="720px" height=auto />
</p>

# <b>OPERATION</b>

 #### <i></b>1] PC Unit</i></b>:
 - Decide next PC value.
 - As here each memory location is of 32 bits so every time, under normal circumstances, PC get incremented by 4
 - If any misalign instr. comes then for that we have misaligned_instr_out
 - If reset then the value of PC becomes 0000H
 - In the case of Branch or Jump instr. we have to jump at a new location, ( for which immediate value is offset to PC)  for that we have i_addr_out 

#### ***2]  Reg Block 1:***
 - It is used for synchronization purpose so that all the signals of stage 1 pass through it so that they are able to reach 2nd stage in 2nd clock cycle

#### ***3] Immediate Generator:***
 - In case of instruction of branch and jump type, we need to make a immediate value which will be later added to PC so that immediate value will be produced by immediate Generator
 - Instr_in gives immediate value and imm_type_in tells it is of which type (branch or jump)

#### ***4] Immediate Adder:***
 - It takes the PC_in and adds it with the immediate value produced by immediate generator and hence successfully generates new value of PC  

#### ***5]  Write Enable Generator:***
 - It generates the write enable signals, which will decide whether we can access the register file for writing / updating any value


#### ***6] Integer File:***
 - The Integer File has 32 general-purpose registers and supports read and write operations. 
 - Reads are requested by pipeline stage 2 and provide data from one or two registers whereas Writes are requested by stage 3 and put the data coming from the Write back Multiplexer into the selected register. 
 - This we have done to avoid DATA HAZARD
 - The first register, i.e. x[0],  is hardwired with 0.

#### ***7] Instruction MUX:***
 - This module takes the instruction (input to core) and provides the fields which are used by the other modules to perform their functionality. 
 - When 'flush' is high, use 32'h00000013 to provide the fields. 
 - When 'flush' is low use core instruction (instr_in) to provide the fields


#### ***8] Decoder:***
 - The Decoder decodes the decoded instruction (from instr. mux) and generates the signals that control various units 

#### ***9] Branch Unit:***
 - Branch conditions are conditional jumps. The Branch Unit decides if a branch instruction must be taken or not. 
 - It receives two operands from the Integer Register File and, based on the value of opcode and funct3 instruction fields, it decides the branch i.e.value of branch_taken_out

#### ***10]  Control Unit:***
 - It can stay in either of the 2 states i.e. Reset State (if rst_in =1) & Operating State
 - It flushes out the PC value in case of branch and jump instructions.

#### ***11] Store Unit:***
 - The Store Unit drives the signals that interface with external data memory. 
 - It places the data to be written (which can be a byte, half word or word) in the right position in data_out and sets the value of wr_mask_out in an appropriate way depending on funct3_in value
 - Then it puts the data back into D-cache depending on value of mem_wr_req_in

#### ***12] Reg Block 2:***
 - It registers all the inputs and produces the outputs at the posedge of clock ,if there is no reset , so that  the signals of stage 2 can't reach stage 3 before 3rd clock cycle.
 - The block also integrates a 2:1 MUX with select-line as branch_taken_in. The LSB of iadder_out_reg_out is assigned with 0 if branch_taken_in is 1, else iadder_out_reg_out [0] is assigned with the registered value of iadder_in[0].

#### ***13] ALU:***
 - The ALU applies ten distinct logical and arithmetic operations in parallel to two 32-bit operands, outputting the result selected by opcode_in

#### ***14] Load Unit:***
 - The Load Unit reads the data_in input signal and forms a 32-bit value based on the load_size_in .
 - Load_size_in tells whether the no. will be byte, half-word or word and iadder_out_1_to_0_in tells at what position it will be placed in o/p
 - The formed value (placed on output) can then be written in the Integer Register File.


#### ***15] WB Mux:***
 - It sends the value that is to be written back into reg. File depending on value of wb_mux_sel_reg_in   
 - For alu_2nd_src_mux_out: –If 'alu_src_reg_in' is high then 'alu_2nd_src_mux_out' = 'rs2__reg_in' else 'alu_2nd_src_mux_out' = 'imm_reg_in'
 - For wb_mux_out, the value will be assigned to depending on value of wb_mux_sel_reg_in 


# **INSTRUCTIONS WITH OUTPUT WAVEFORMS**


-  <i>R-TYPE</i>

    - R-type instructions involve operation between two operands stored in two on-chip registers. The fetched instruction should provide the address to the two operands and help the processor to decode the type of operation to be performed.

     - **EXAMPLE**
       - Instruction: add x28, x12, x13
        - Description: The contents of register x1 and x12 are to be added and stored back to the x2 register.

     - As per the [ISA](https://riscv.org/wp-content/uploads/2019/12/riscv-spec-20191213.pdf),

        - Hex equivalent: 00d60e33
         
        - Bin equivalent: 00000000110101100000111000110011
         
        - Opcode: 011_0011
         
        - funct3: 3’b000
         
        - funct7: 7’b000_0000
         
        - rs1_addr: 5’hC
         
        - rs2_addr: 5’hd
         
        - rd_addr: 5’h1C
        
        - The instruction has been stored at memory location: 40 (or 28H)
        
        - Machine cycles taken: 1
        
        - No. of clock cycles: 3
        
     - Working:
         
        - In the first cycle, the address from the processor is sent to the icache and instruction reaches the processor in the second cycle.
        - In next cycle, the instruction is decoded and data is read from the on-chip registers
        - In the third cycle, the addition is performed and data is sent to on-chip registers for storage.
        
      - Tool Simulation:

    <p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/6a0518be-b13e-4db1-a781-a7a4be69dbe7" width="720px" height=auto />
</p>



- <I>I-TYPE</I>

    - I-type instructions involve operation between two  operands, one stored in an on-chip register and the other is an immediate operand available in the instruction itself. The fetched instruction should provide the address to the operand and help the processor to decode the type of operation to be performed and the immediate value is given to the processor as a second operand. Note: We must not ignore the fact that the immediate value can be maximum of 12-bits, as per the field size decided by the instruction format. This issue is solved later when we use AUIPC/LUI instructions.

    - **EXAPMLE**
      - Instruction: addi x10, x11, 2
      - Description: The contents of register x11 and immediate value 2 are to be added and stored back to the x10 register.

    - As per the [ISA](https://riscv.org/wp-content/uploads/2019/12/riscv-spec-20191213.pdf),

      - Hex equivalent: 00d60e33
      
      - Bin equivalent: 00000000110101100000111000110011
       
      - Opcode: 011_0011
       
      - funct3: 3’b000
       
      - funct7: 7’b000_0000
       
      - rs1_addr: 5’hC
       
      - rs2_addr: 5’hd
       
      - rd_addr: 5’h1C
       
      - The instruction has been stored at memory location: 40 (or 28H)
       
      - Machine cycles taken: 1
       
      - No. of clock cycles: 3
       
  -  Working:
      
      - In the first cycle, the address from the processor is sent to the icache and instruction reaches the processor in the second cycle.
      - In next cycle, the instruction is decoded and data is read from the on-chip registers
      - In the third cycle, the addition is performed and data is sent to on-chip registers for storage.

  - Tool Simulation:

  <p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/6bdc7fa3-9e27-47e5-aa54-f10a8207f4fe" width="720px" height=auto />
</p>

- <I>S-TYPE</I>

    - S-Type instructions in the RISC-V architecture enable the storing of register values into memory at specific offsets determined by immediate values within the instruction. These instructions facilitate the interaction between registers and memory, allowing data to be stored at calculated memory addresses. For instance, the sw (store word) instruction takes a value from a register and writes it into memory at an address derived by adding the immediate value to a base address obtained from a register. S-Type instructions are fundamental for memory manipulation within the RISC-V architecture.

    - **EXAMPLE**
      - Instruction: sh x12, 0x6(x10)
      - Description: The contents of register x12 are stored to data memory(dcache) via the store unit. Since this is sh instruction, only half word is loaded to the memory location [6H + [x10]], content of [x10] in this case is 2H. Hence, the destination address in this case is 8H.

    - As per the [ISA](https://riscv.org/wp-content/uploads/2019/12/riscv-spec-20191213.pdf),

        - Hex equivalent: 00258513
         
        - Bin equivalent: 00000000001001011000010100010011
         
        - Opcode: 001_0011
         
        - funct3: 3’b000
         
        - funct7: 7’b000_0000
         
        - rs1_addr: 5’hB
         
        - rs2_addr: (ignorable)
         
        - rd_addr: 5’hA
         
        - The instruction has been stored at memory location: 40 (or 28H)
         
        - Machine cycles taken: 1
         
        - No. of clock cycles: 3
         
    - Working:
        
        - In the first cycle, the address from the processor is sent to the icache and instruction reaches the processor in the second cycle.
        - In next cycle, the instruction is decoded and data is read from the on-chip registers
        - In the third cycle, the addition is performed and data is sent to on-chip registers for storage.

   - Tool Simulation:

     <p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/235bdd67-e40c-48aa-8b5a-5c5f790199f4" width="720px" height=auto />
</p>
        
- <I>B-TYPE</I>

    - The B-Type instructions in RISC-V architecture are responsible for conditional branching, enabling the processor to change the flow of execution based on specific conditions. These instructions utilize immediate values to determine the offset for branching, allowing the program to jump to a new address if a certain condition is met. For instance, the beq (branch if equal) instruction compares two registers and, if they are equal, calculates the target address by adding the immediate offset to the current program counter. B-Type instructions are pivotal for implementing conditional logic and enabling control flow within RISC-V programs.

    - **EXAMPLE**
      - Instruction: bltu x10, x12, 0x14
      - Description: The control is passed to PC 0x14 if the contents of memory location [x10] is less than that of [x12] (unsigned comparison). These are conditional jump statements in the RV32I instruction set.
      - X10 = 2
      - X12 = 3 Therefore, a branch is taken. Hence PC Value changes to 18H + 14H = 2C

    - As per the [ISA](https://riscv.org/wp-content/uploads/2019/12/riscv-spec-20191213.pdf),

      - Hex equivalent: 00c56a63
       
      - Bin equivalent: 00000000110001010110101001100011
       
      - Opcode: 110_0011
       
      - funct3: 3’b110
       
      - funct7: 7’b000_0000
       
      - rs1_addr: 5’bA
       
      - rs2_addr: 5’bC
       
      - The instruction has been stored at memory location: 24 (or 18H)
       
      - Machine cycles taken: 1
       
      - No. of clock cycles: 3 
      
  -   Working:
       
      - In the first cycle, the address from the processor is sent to the imem and instruction reaches the processor in the second cycle.
       
      - In the next cycle, the instruction is decoded, equality is tested and the new PC is calculated and forwarded.
       
      - In the third cycle, the same value is observed in wb_mux out as well. The new PC is forwarded in 2nd cycle itself to prevent pipeline stall. 
      
    - Tool Simulation:
       
        <p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/c1eea0da-426f-4f19-96bd-c2e836e84337" width="720px" height=auto />
</p>

- <I>J-TYPE</I>

    - The J-Type instructions in RISC-V architecture are responsible for unconditional jumping or jumping to a new address without any condition checks. They facilitate the transfer of control to a new location by using a target address derived from the immediate value within the instruction. For instance, the jal (jump and link) instruction sets the program counter to a new address formed by combining the immediate offset with the current program counter value, allowing the processor to jump to a different part of the code while also saving the address of the next instruction in a designated register (usually the link register). J-Type instructions are essential for implementing function calls, loops, and other forms of non-conditional jumps in RISC-V programs.

    - **EXAMPLE**
       - Instruction: jalr x10, x12, 0x1

      -  Description: The control is passed to PC 0x4 unconditionally. The previous PC+4H value is stored in destination register X10.

       -  X12 = 3 A branch is taken. Hence, PC Value changes to 3H + 1H = 4H

    - As per the [ISA](https://riscv.org/wp-content/uploads/2019/12/riscv-spec-20191213.pdf),

      - Hex equivalent: 00160567
       
      - Bin equivalent: 00000000000101100000010101100111
       
      - Opcode: 110_0111
       
      - funct3: 3’b000
       
      - funct7: 7’b000_0000
       
      - rs1_addr: 5’bC
       
      - rs2_addr: (ignorable)
       
      - rd_addr: 5’bA
       
      - The instruction has been stored at memory location: 24 (or 18H)
       
      - Machine cycles taken: 1
       
      - No. of clock cycles: 3
       
    - Working:
       
      - In the first cycle, the address from the processor is sent to the imem and instruction reaches the processor in the second cycle.
      - In the next cycle, the instruction is decoded and the new PC is calculated and forwarded.
      - In the third cycle, the same value is observed in wb_mux out as well.
      - The new PC is forwarded in 2nd cycle itself to prevent pipeline stall.
       
     - Tool Simulation:

         <p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/a386f1b9-2cbb-4df2-a7b4-9b6ba5b526a7" width="720px" height=auto />
</p>

- <I>U-TYPE</I>

  - The U-Type instructions in RISC-V architecture are designed for unconditional immediate operations. These instructions facilitate the addition of an immediate value to the program counter to generate a new target address for execution. The U-Type instructions allow for the direct manipulation of the program counter by using an immediate value to form a new address. For instance, the lui (load upper immediate) instruction loads a 20-bit immediate value into the upper 20 bits of a register, effectively setting the register to the immediate value shifted left by 12 bits. U-Type instructions are fundamental for immediate operations that involve setting specific upper bits of a register or generating immediate values for calculations or address formation in RISC-V programs.

  - **EXAMPLE**
    - Instruction: lui x12, 0x12345
    - Description: The immediate value 0x12345 is stored in upper bytes of x12 register. The main objective of LUI instruction is to add immediate values up to 20 bits which was not possible with I-type instructions.

  - As per the [ISA](https://riscv.org/wp-content/uploads/2019/12/riscv-spec-20191213.pdf),

    - Hex equivalent: 12345637
     
    - Bin equivalent: 00010010001101000101011000110111
     
    - Opcode: 011_0111
     
    - funct3: 3’b000
     
    - funct7: 7’b000_0000
     
    - rs1_addr: (ignorable)
     
    - rs2_addr: (ignorable)
     
    - rd_addr: 5’bC
     
    - The instruction has been stored at memory location: 24 (or 18H)
     
    - Machine cycles taken: 1
     
    - No. of clock cycles: 3
     
  - Working:
     
    - In the first cycle, the address from the processor is sent to the imem and instruction reaches the processor in the second cycle.
    - In next cycle, the immediate data is sent to reg_block2
    - In the third cycle, the data is sent to on-chip registers for storage.

  - Tool Simulation:

      <p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/c62b6d4c-5b38-4646-9fc7-018d38215253" width="720px" height=auto />
</p>
