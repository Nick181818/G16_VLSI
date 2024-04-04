# <b>STRV32I</b>
STRV32I is actually a RISC-V. RISC-V 32 refers to the 32-bit version of the RISC-V instruction set architecture (ISA). 
Like its 64-bit counterpart, RISC-V 32 is based on the principles of Reduced Instruction Set Computing (RISC).
RISC-V 32 is a version of the RISC-V instruction set architecture that operates with 32-bit data and addresses. 

  It  prioritizes simplicity and efficiency in processor design. RISC-V 32, like its 64-bit counterpart, is modular, open-source, and allows for optional extensions to support specific functionalities. It's suitable for a wide range of applications, from embedded systems to smartphones, offering versatility and flexibility.


  
  <b>

## CONTENTS

 * DESIGN SPECIFICATIONS
 * FILES IN THIS SUBMISSION
 * INTRODUCTION
 * STRV32I STRCUTURE
 * OPERATION
 * INSTRUCTIONS
 * OUTPUT  
  </b>

# <b>DESIGN SPECIFICATIONS</b>
Design a 3-stage pipelined RISC-V processor that works on RV32I ISA.

1. Interface:

  - 	clk_in: System clock.

  - 	rst_in: Active high and synchronous system reset.

2.	Instruction Cache Interface:

  - 	imaddr_out: Carries 32-bit target address to icache.

  - 	instr_in: 32-bit instruction fetched from icache.

3.	Data Cache Interface:

  - 	dmwr_req_out: Write request signal to dcache, when high indicates a write request to dcache while being low it indicates a read request. This is a single bit signal.

  - 	dmaddr_out: Carries the 32-bit target(read/write) address to dcache.

  - 	dmdata_in: This is the 32-bit data read from dcache. During the Load.

  - 	dmdata_out: This is the 32-bit data to be written to dcache. During the Store.

  - 	dmwr_mask_out: This is a 4-bit mask signal that decides the bits to be masked during the dcache write operation.


  ####  Input And Output Description
|Port name |Direction|Type|Description|
|---|---|---|---|
|clk_in|input| |System Clock|
|rst_in|input| |System Reset|
|dmdata_in|input| [31:0]| Data input from dcache|
|instr_in|input| [31:0]|Instruction input from icache|
|dmwr_req_out|output| |Write request to dcache|
|imaddr_out|output| [31:0]|Address output to icache|
|dmaddr_out|output| [31:0]|Address output to dcache|
|dmwr_mask_out|output | [3:0]| Mask bits to dcache|
|dmdata_out|output| [31:0]|Data output to dcache|

# <b>FILES IN THIS SUBMISSIONS</b>

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
 - **Readme.md** - This is a markdown file which contains all the report of project.
 - **Riscv_Top.v** - This is the Top Module and it contains all the Instantiations of 
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
 - **Riscv_tb.v** - This is a test bench file recquired to play along the input values.

 - **Instr_File.mem** - This is an Instruction File which has instruction operations to do while executing a program.

# <b>INTRODUCTION</b>
Computers are built on specific architectural designs that dictate how instructions are executed and processed. Two primary architectures exist: Complex Instruction Set Computer (CISC) and Reduced Instruction Set Computer (RISC).


#### Block Diagram

<p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/d673f2cc-ad36-4fa1-b653-dce3de226bfe" width="720px" height=auto />
</p>


<i><b> RISC (Reduced Instruction Set Computer)</i></b>
RISC architecture, on the contrary, focuses on a reduced set of simple instructions, each typically executed in a single clock cycle. This simplicity results in faster execution and improved performance.
RISC architectures prioritize efficiency by favoring a smaller set of instructions, emphasizing faster instruction execution, and enabling better pipelining and parallelism. Notable RISC architectures include ARM and MIPS.

RISC-V stands as a cutting-edge open-source instruction set architecture (ISA) that embodies simplicity, adaptability, and versatility. Developed at the University of California, Berkeley, the RISC-V ISA was introduced in 2010 as an academic project aiming to address the limitations of existing architectures and provide a platform for innovation in computer architecture.

 #### <b>RISC architecture consists of a series of stages that an instruction goes through during its execution:</b>
1.	<i><b>Instruction Fetch</i></b>: The CPU fetches the instruction from memory.
2.	<i><b>Decode</i></b>: The instruction is decoded to determine the operation to be performed.
3.	<i><b>Execute</i></b>: The CPU executes the operation specified by the instruction.
4.	<i><b>Memory Access</i></b>: If necessary, the CPU accesses memory to read or write data.
5.	<i><b>Write Back</i></b>: The CPU writes the results of the operation back to the appropriate register or memory location.

<p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/b0c15599-405b-46a0-b975-12f3d3d86a02" width="720px" height=auto />
</p>


##	<b>Advantages of RISC-V</b>
RISC-V stands as a beacon in modern computing due to its revolutionary features and adaptable nature, encompassing several advantages:

*	Openness and Accessibility: RISC-V's open-source nature democratizes access to the ISA, enabling innovation without licensing fees or restrictions.

*	Flexibility and Customizability: The modular design allows users to tailor solutions by incorporating custom instructions or extensions, fostering adaptability across diverse applications.

*	Scalability and Versatility: Supporting various versions like RV32I, RV64I, and RV128I, RISC-V addresses different performance needs and computing environments.

*	Elegance and Simplicity: RISC-V's streamlined design emphasizes a reduced instruction set, enhancing predictability, ease of implementation, and efficiency.
	
*	High Extensibility: A pivotal feature of RISC-V is its exceptional extensibility. This attribute enables users to expand the instruction set architecture by incorporating custom instructions or entire extensions. Its extensibility allows for the addition of new features, optimizations, and specialized functionalities, ensuring adaptability to evolving technological requirements and computing paradigms.

 

# <b>STRV32I STRCUTURE</b>

<p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/9d19a51f-33e1-4feb-a55d-7e970d64578d" width="720px" height=auto />
</p>

# <b>OPERATION</b>
 #### <i></b>PC Unit</i></b>:
The Program Counter is a register in a CPU that stores the memory address of the next instruction to be fetched and executed. It keeps track of the current position in the program's execution sequence.

#### Block Diagram

<p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/7591cb72-ee49-4ff1-907c-bf5f63046ef9" width="720px" height=auto />
</p>


### <i><b>Branch Unit:</i></b>

One of the key functions of the branch unit is to predict the outcome of branch instructions before their execution. This prediction is based on various factors, such as the history of previous branches, the program counter (PC), and branch history tables. Predicting whether a branch will be taken (i.e., the condition will evaluate to true) or not taken (i.e., the condition will evaluate to false) is crucial for minimizing pipeline stalls and improving performance.When a branch instruction is encountered, the branch unit calculates the target address of the branch. This target address determines the location in the instruction stream where program execution will continue after the branch is resolved.

#### Block Diagram


<p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/97d95453-5d7a-4986-8204-147880c82ca5" width="720px" height=auto />
</p>


### <i><b>Control unit</i></b>

The Control Unit (CU) is a core component of the Central Processing Unit (CPU) responsible for coordinating and directing the operation of the entire processor. It interprets and executes instructions, directing the flow of data between the CPU's various functional units and external devices. The primary functions of the control unit include instruction decoding, instruction sequencing, and generating control signals to coordinate the operation of other CPU components.

#### Block Diagram


<p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/f381bc50-e0c9-49d5-bbe1-b10ca96ca7cd" width="720px" height=auto />
</p>


### <i><b>Instruction Unit</i></b>

An instruction multiplexer (mux) is a component within a CPU's control unit responsible for selecting the next instruction to be executed from among multiple possible sources. It plays a crucial role in directing the flow of instruction execution within the CPU.Instruction muxes are often used at various stages of the CPU's instruction pipeline to select the appropriate instruction for each pipeline stage. This helps ensure that instructions are fetched and processed efficiently, minimizing pipeline stalls and improving overall CPU performance.

#### Block Diagram


<p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/e1e1201b-7418-4a42-949b-03e398055530
 " width="720px" height=auto />
</p>


### <i><b>Write Enable Generator</i></b>

A write enable generator is a component within a computer system, often found in memory and input/output (I/O) interfaces, that generates signals to control when data can be written to a specific location in memory or when output data can be enabled for transmission.The write enable generator plays a crucial role in coordinating write operations in computer systems, ensuring that data is written or output only when appropriate and in a manner consistent with the system's operation.

#### Block Diagram


<p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/3553ddfb-46ec-4247-b4f1-846d79054dc3" width="720px" height=auto />
</p>


### <i><b>Immediate Adder</i></b>

An immediate adder, also known as a constant adder or immediate arithmetic unit, is a component found within a CPU's arithmetic logic unit (ALU) that performs addition operations involving immediate values or constants.Immediate adders are commonly used in CPU architectures to perform arithmetic operations that involve immediate values, such as adding constants to variables or performing arithmetic with small fixed values. They play a crucial role in executing instructions efficiently, particularly in the context of arithmetic and logical operations with immediate operands.

#### Block Diagram


<p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/ae0b8478-df18-4a32-816e-c764c85724b6" width="720px" height=auto />
</p>


### <i><b>Immediate Generator</i></b>

Immediate generators are essential for efficient execution of instructions that involve immediate operands, as they eliminate the need to access memory or registers to fetch these constants, thereby reducing latency and improving performance.

Constant Encoding: In some architectures, the immediate values are encoded directly within the instruction bits. The immediate generator decodes these encoded values and provides them to the execution units.

Sign Extension: For signed immediate values, the immediate generator may perform sign extension, which extends the sign bit of the immediate value to fill the full width of the operand, ensuring correct arithmetic operations.

Zero Extension: Similarly, for unsigned immediate values, the immediate generator may perform zero extension, which fills the unused bits with zeroes to match the operand width.

Shift and Masking: In some cases, the immediate generator may perform shifting or masking operations to adjust the immediate value according to the instruction's requirements.

#### Block Diagram


<p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/0152b296-7488-46b2-a242-2fbe80d389ae" width="720px" height=auto />
</p>


### <i><b>ALU Unit</i></b>
The Arithmetic Logic Unit (ALU) is a fundamental component of a CPU responsible for performing arithmetic and logical operations on data. It's a combinational circuit that takes input data from registers, performs the specified operation, and produces the result.

Inputs: The ALU receives operands from CPU registers or memory. These operands are the data on which the arithmetic or logical operation is to be performed. In some cases, the ALU may also receive control signals specifying the operation to be executed.

Operations: The ALU can perform a variety of operations, including addition, subtraction, AND, OR, XOR, shift operations (left shift, right shift), comparison (equality, less than, greater than), and more. The specific operation performed is determined by control signals received by the ALU.

Output: After performing the operation, the ALU produces a result, which is typically stored back in a register or sent to another part of the CPU for further processing. The output may also include status flags indicating the result of the operation, such as overflow, carry, zero, or negative flags.

Speed and Efficiency: ALUs are designed to perform operations quickly and efficiently, often using parallelism and pipelining techniques to maximize throughput. They are critical for the overall performance of the CPU, as many instructions executed by the CPU involve operations performed by the ALU.

#### Block Diagram


<p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/09754fea-7aeb-4d69-8574-5588c6f79217
 " width="720px" height=auto />
</p>



### <i><b>Store unit</i></b>

A "store unit" in a computer architecture context typically refers to the component responsible for performing store or write operations to memory. It's a part of the memory subsystem of a CPU and is involved in transferring data from registers or caches to memory.The store unit plays a crucial role in the memory subsystem of a CPU, facilitating the efficient transfer of data between the CPU and memory. Its performance and reliability are essential for the overall system performance and data integrity.

#### Block Diagram

<p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/41840370-2ec0-4293-9294-a65bcfc29f81" width="720px" height=auto />
</p>



### <i><b>Write Back</i></b>

In computer architecture, "write back" typically refers to a memory access strategy used in caching systems, particularly in the context of cache coherence protocols and CPU cache management.
Cache Operation: In a CPU cache, data is typically stored in cache lines, each containing a block of memory. When the CPU reads data from memory, it first checks if the data is present in the cache. If the data is found in the cache (a cache hit), the CPU can retrieve it directly from the cache without accessing main memory, which is faster.

Write Operations: When the CPU needs to write data to memory, it first checks if the corresponding cache line containing the memory location is present in the cache. If the data is already in the cache, the CPU can update the cache line directly without accessing main memory. However, instead of immediately updating the main memory, the CPU may choose to update the cache line and mark it as "dirty" to indicate that it has been modified.

#### Block Diagram

<p align ="center">
 <img src="https://github.com/touheed1829/PROJECTS/assets/142418059/271fe94e-08cf-4d84-bd00-12675dd7fc65" width="720px" height=auto />
</p>



# **INSTRUCTIONS**


-  <i>R-TYPE</i>

    - R-type instructions involve operation between two operands stored in two on-chip registers. The fetched instruction should provide the address to the two operands and help the processor to decode the type of operation to be performed.

     - **EXAMPLE**
       - Instruction: add x28, x12, x13
        - Description: The contents of register x1 and x12 are to be added and stored back to the x2 register.

     - As per the ISA,

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

    - As per the ISA,

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

    - As per the ISA,

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

    - As per the ISA,

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

    - As per the ISA,

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

  - As per the ISA,

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

