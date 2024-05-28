# <i><b>STRV32I</i></b>
STRV32I is actually a RISC-V. RISC-V 32 refers to the 32-bit version of the RISC-V instruction set architecture (ISA). Like its 64-bit counterpart, RISC-V 32 is based on the principles of Reduced Instruction Set Computing (RISC).
RISC-V 32 is a version of the RISC-V instruction set architecture that operates with 32-bit data and addresses. It  prioritizes simplicity and efficiency in processor design. RISC-V 32, like its 64-bit counterpart, is modular, open-source, and allows for optional extensions to support specific functionalities. It's suitable for a wide range of applications, from embedded systems to smartphones, offering versatility and flexibility.


<i><b>

# CONTENT
* DESIGN SPECIFICATIONS
* INTRODUCTION
* Advantages of 3-stage pipelined
* OPERATION
* OUTPUT
</i></b>

# <i><b>DESIGN SPECIFICATIONS</i></b>
Design a 3-stage pipelined RISC-V processor that works on RV32I ISA.

1. Interface:

+	clk_in: System clock (10Mhz).

+	rst_in: Active high and synchronous system reset.

2.	Instruction Cache Interface:

+	imaddr_out: Carries 32-bit target address to icache.

+	instr_in: 32-bit instruction fetched from icache.

3.	Data Cache Interface:

+	dmwr_req_out: Write request signal to dcache, when high indicates a write request to dcache while being  low it indicates a read request. This is a single bit signal.

+	dmaddr_out: Carries the 32-bit target(read/write) address to dcache.

+	dmdata_in: This is the 32-bit data read from dcache. During the Load.

+	dmdata_out: This is the 32-bit data to be written to dcache. During the Store.

+	dmwr_mask_out: This is a 4-bit mask signal that decides the bits to be masked during the dcache write operation.

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

# <i><b>INTRODUCTION</i></b>

Computers are built on specific architectural designs that dictate how instructions are executed and processed. Two primary architectures exist: Complex Instruction Set Computer (CISC) and Reduced Instruction Set Computer (RISC).

<i><b> RISC (Reduced Instruction Set Computer)</i></b>
RISC architecture, on the contrary, focuses on a reduced set of simple instructions, each typically executed in a single clock cycle. This simplicity results in faster execution and improved performance.
RISC architectures prioritize efficiency by favoring a smaller set of instructions, emphasizing faster instruction execution, and enabling better pipelining and parallelism. Notable RISC architectures include ARM and MIPS.

RISC-V stands as a cutting-edge open-source instruction set architecture (ISA) that embodies simplicity, adaptability, and versatility. Developed at the University of California, Berkeley, the RISC-V ISA was introduced in 2010 as an academic project aiming to address the limitations of existing architectures and provide a platform for innovation in computer architecture.
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/4321b57c-188d-4883-b5cb-0f72436715a5" width="720px" height=auto />
</p>

 #### <i><b>RISC architecture consists of a series of stages that an instruction goes through during its execution:</i></b>
1.	<i><b>Instruction Fetch</i></b>: The CPU fetches the instruction from memory.
2.	<i><b>Decode</i></b>: The instruction is decoded to determine the operation to be performed.
3.	<i><b>Execute</i></b>: The CPU executes the operation specified by the instruction.
4.	<i><b>Memory Access</i></b>: If necessary, the CPU accesses memory to read or write data.
5.	<i><b>Write Back</i></b>: The CPU writes the results of the operation back to the appropriate register or memory location.

<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/1cc47fd0-adef-4424-8697-46ae7f6f82f6" width="720px" height=auto />
</p>


#### 	<i><b>Advantages of RISC-V</i></b>
RISC-V stands as a beacon in modern computing due to its revolutionary features and adaptable nature, encompassing several advantages:

*	<b>Openness and Accessibility</b>: RISC-V's open-source nature democratizes access to the ISA, enabling innovation without licensing fees or restrictions.

*	<b>Flexibility and Customizability</b>: The modular design allows users to tailor solutions by incorporating custom instructions or extensions, fostering adaptability across diverse applications.

*	<b>Scalability and Versatility</b>: Supporting various versions like RV32I, RV64I, and RV128I, RISC-V addresses different performance needs and computing environments.

*	<b>Elegance and Simplicity</b>: RISC-V's streamlined design emphasizes a reduced instruction set, enhancing predictability, ease of implementation, and efficiency.
	
*	<b>High Extensibility</b>: A pivotal feature of RISC-V is its exceptional extensibility. This attribute enables users to expand the instruction set architecture by incorporating custom instructions or entire extensions. Its extensibility allows for the addition of new features, optimizations, and specialized functionalities, ensuring adaptability to evolving technological requirements and computing paradigms.

# <i><b>Advantages of 3-stage pipelined</i></b>
* <i><b>Increased Throughput</i></b>: Pipelining enables multiple instructions to be processed simultaneously, enhancing the overall throughput of the CPU.
* <i><b>Improved Efficiency</i></b>: Concurrent execution of instructions reduces idle time in the CPU, making better use of resources.
* <i><b>Enhanced Performance</i></b>: By breaking down instruction execution into smaller stages, pipelining speeds up the overall execution of instructions.
* <i><b>Resource Utilization</i></b>: It allows the CPU to operate at a higher clock frequency by leveraging parallel processing, thereby utilizing resources more efficiently.

#### Deliverables:
* <i><b>Performance Analysis</i></b>: Clock cycle count, throughput, and latency for various instructions and instruction sequences.
* <i><b>Pipeline Diagram</i></b>: Illustration of pipeline stages and instruction flow.
* <i><b>Hazard Detection and Resolution</i></b>: Explanation of data hazards, control hazards, and structural hazards detection and mitigation.
* <i><b>Memory Subsystem</i></b>: Description of memory access handling, including memory hierarchy and cache structure.
* <i><b>Forwarding and Stall Mechanisms</i></b>: Description of data forwarding and stall mechanisms for maintaining correct instruction execution.
* <i><b>Exception Handling</i></b>: Explanation of how exceptions, interrupts, traps, and system calls are handled.
* <i><b>Verification Plan</i></b>: Methodology and tools used for verifying the correctness of the processor design.


# <i><b>OPERATION</i></b>

* <i><b>PC Unit</i></b>:

  - The PC unit, or Program Counter unit, manages the program counter, a register that holds the memory address of the next instruction to be fetched, facilitating sequential instruction execution and control flow management.

* <i><b>Branch Unit</i></b>

  - The branch unit in RISC-V handles branch instructions, predicting branch outcomes and calculating branch targets, crucial for controlling program flow and minimizing pipeline stalls.

* <i><b>Control unit</i></b>

  - The control unit in a CPU coordinates instruction execution, generating control signals to manage data flow between CPU components, decoding instructions, and directing operations such as arithmetic and logical calculations.
  - It oversees the fetch-decode-execute cycle, ensuring efficient processing and proper sequencing of instructions.

* <i><b>Instruction Unit</i></b>

  - The instruction unit is responsible for fetching instructions from memory, decoding them, and passing them to the appropriate execution units within the CPU for processing. 
  - It manages the instruction pipeline, ensuring smooth and efficient operation of the CPU.


* <i><b>Write Enable Generator</i></b>

  - Write enable generator is a component within a memory system that generates control signals to enable or disable write operations to specific memory locations.
  - It interprets commands from the CPU or other controlling units and generates the necessary signals to allow data to be written into the designated memory cells while ensuring data integrity and consistency.

* <i><b>Immediate Adder</i></b>

  - Immediate adder is a component within a CPU's arithmetic logic unit (ALU) that performs addition operations involving immediate values. 
  - It adds a constant value, often encoded directly within the instruction, to the contents of a register or memory location. 
  - This operation is commonly used in instruction execution for arithmetic calculations, memory address computation, and branch target calculation in various processor architectures.


* <i><b>Immediate Generator</i></b>

  - An immediate generator is a CPU component that creates constant values directly encoded within instructions, used for operations like arithmetic, memory addressing, or branching.


* <i><b>Decoder Unit</i></b>

  - The decoder unit interprets binary instructions fetched from memory, determining the operation to be performed and the operands involved.

  - It translates decoded instructions into control signals, coordinating the actions of other CPU components to execute the instruction effectively.


* <i><b>ALU Unit</i></b>

  - The ALU (Arithmetic Logic Unit) in RISC-V performs arithmetic and logical operations on data.

  - It supports basic arithmetic operations such as addition, subtraction, multiplication, and division, as well as logical operations like AND, OR, XOR, and shifting.

  - The ALU operates on data from registers or immediate values, generating results based on control signals provided by the CPU's control unit.


* <i><b>Load unit</i></b>

  - The load unit in RISC-V is responsible for loading data from memory into CPU registers, typically used for accessing variables or data structures stored in memory.

  - It calculates memory addresses based on operands and immediate values, initiates memory access operations, and transfers the retrieved data into the specified CPU registers for further processing.

* <i><b>Store unit</i></b>

  - In RISC-V, the store unit is responsible for transferring data from CPU registers to memory locations specified by the instruction, typically used for storing variables or updating data structures in memory.

  - It calculates memory addresses based on operands and immediate values, initiates memory write operations, and transfers the data from the specified CPU registers to the corresponding memory locations.

# <i><b> OUTPUT</i></b>

*  <i><b>R-Type </i></b>
These instructions operate on data held in registers. It cover arithmetic (such as addition, subtraction), logical (AND, OR, XOR), and shift operations sll (logical left shift), srl (logical right shift), etc.


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
        - rs2_addr: 5’hD
        - rd_addr: 5’h1C
        - The instruction has been stored at memory location: 40 (or 28H)
        - Machine cycles taken: 1    
        - No. of clock cycles: 3
        
     - Working:
         
        - In the first cycle, the address from the processor is sent to the icache and instruction reaches the processor in the second cycle.
        - In next cycle, the instruction is decoded and data is read from the on-chip registers
        - In the third cycle, the addition is performed and data is sent to on-chip registers for storage.
        
        
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/587fc4db-2004-4f34-9899-b93843779a43" width="720px" height=auto />
</p>

*  <i><b>I-Type </i></b>

I-type instructions execute operations like immediate arithmetic (addition, subtraction) and immediate logical operations on values loaded from memory or registers. The operations like addi (add immediate), subi (subtract immediate), andi (AND immediate), ori (OR immediate), lw (load word), sw (store word), etc.

- **EXAPMLE**
    - Instruction: addi x10, x11, 2
    - Description: The contents of register x11 and immediate value 2 are to be added and stored back to 
      thex10 register.

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
           
  -  Working:
      
      - In the first cycle, the address from the processor is sent to the icache and instruction reaches the processor in the second cycle.
      - In next cycle, the instruction is decoded and data is read from the on-chip registers
      - In the third cycle, the addition is performed and data is sent to on-chip registers for storage.


<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/2067f565-b297-41d6-8411-07900472a724" width="720px" height=auto />
</p>

*  <i><b>S-Type </i></b>

 S-Type instructions in the RISC-V architecture primarily used for storing values in memory locations. It store a register value into memory at an offset determined by an immediate value.
 - **EXAMPLE**
      - Instruction: sh x12, 0x6(x10)
      - Description: The contents of register x12 are stored to data memory(dcache) via the store unit. Since this is sh instruction, only half word is loaded to the memory location [6H + [x10]], content of [x10] in this case is 2H. Hence, the destination address in this case is 8H.

    - As per the ISA,
        - Hex equivalent: 00C51323
        - Bin equivalent: 00000000110001010001001100100011
        - Opcode: 010_0111
        - funct3: 3’b001
        - funct7: 7’b000_0000
        - rs1_addr: 5’hA
        - rs2_addr: 5’hC
        - rd_addr: (ignorable)
        - The instruction has been stored at memory location: 40 (or 28H)
        - Machine cycles taken: 2         
        - No. of clock cycles: 3
         
    - Working:
        
        - In the first cycle, the address from the processor is sent to the icache and instruction reaches the processor in the second cycle.
        - In next cycle, the instruction is decoded and data is read from the on-chip registers
        - In the third cycle, the addition is performed and data is sent to on-chip registers for storage.



<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/a051f898-db8e-41bd-b978-ecf9da472c21" width="720px" height=auto />
</p>

*  <i><b>B-Type </i></b>

The B-Type instructions in RISC-V architecture are execute conditional branches based on comparisons.
Employ immediate values for branching, facilitating conditional jumps.


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
    
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/5aa9bf98-0abe-4f72-9f06-4a05b3d0cdd0" width="720px" height=auto />
</p>

* <i><b>J-Type </i></b>

The J-Type instructions in RISC-V architecture are responsible  for altering the program flow.
JAL (Jump and Link) stores the address of the next instruction into a register and jumps to a calculated address.
JALR (Jump and Link Register) jumps to an address stored in a register and stores the return address in a specified register.

- **EXAMPLE**
    - Instruction: jalr x10, x12, 0x1

    - Description: The control is passed to PC 0x4 unconditionally. The previous PC+4H value is stored in destination register X10. X12 = 3 A branch is taken. Hence, PC Value changes to 3H + 1H = 4H

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
    
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/c546ed82-da62-4020-9ef1-72a3c7ca85ac" width="720px" height=auto />
</p>

* <i><b>U-type</i></b>

The U-Type instructions in RISC-V architecture are designed for unconditional immediate value-based operations.
Mainly deal with setting or manipulating large immediate values in the upper bits of a register.

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

<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/4dd044f5-2490-491e-bd35-6d908f796d90" width="720px" height=auto />
</p>


