# <i><b>STRV32I</i></b>
STRV32I is actually a RISC-V. RISC-V 32 refers to the 32-bit version of the RISC-V instruction set architecture (ISA). Like its 64-bit counterpart, RISC-V 32 is based on the principles of Reduced Instruction Set Computing (RISC).
RISC-V 32 is a version of the RISC-V instruction set architecture that operates with 32-bit data and addresses. It  prioritizes simplicity and efficiency in processor design. RISC-V 32, like its 64-bit counterpart, is modular, open-source, and allows for optional extensions to support specific functionalities. It's suitable for a wide range of applications, from embedded systems to smartphones, offering versatility and flexibility.


<i><b>
# CONTENT
* DESIGN SPECIFICATIONS
* INTRODUCTION
* STRV32I STRCUTURE
* OPERATION
* OUTPUT
* WAVEFORM
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

 

# <i><b>STRV32I STRCUTURE</i></b>

<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/7d9e10a2-418e-4214-86ed-4e2cbb0f1953" width="720px" height=auto />
</p>

# <i><b>OPERATION</i></b>

 * <i><b>PC Unit</i></b>:

The Program Counter is a register in a CPU that stores the memory address of the next instruction to be fetched and executed. It keeps track of the current position in the program's execution sequence.
<b>Fetching Instructions</b>: The Program Counter unit is responsible for fetching instructions from memory. It retrieves the instruction located at the memory address stored in the Program Counter register.

<b>Incrementing</b>: After fetching an instruction, the Program Counter is typically incremented to point to the next instruction in memory. This prepares it to fetch the next instruction in the sequence.

<b>Branching</b>: During program execution, control flow instructions such as branches (conditional or unconditional) may alter the flow of execution. In such cases, the Program Counter is updated to point to a different memory address based on the branch condition or target address.

<b>Jumping</b>: Jump instructions, which transfer control to a different part of the program, also involve modifying the Program Counter. The new memory address to jump to is typically loaded into the Program Counter, redirecting the execution flow.

<b>Interrupts and Exceptions</b>: When handling interrupts or exceptions, the Program Counter may be saved or modified to ensure proper program execution after the interrupt is serviced.


* <i><b>Branch Unit</i></b>

One of the key functions of the branch unit is to predict the outcome of branch instructions before their execution. This prediction is based on various factors, such as the history of previous branches, the program counter (PC), and branch history tables. Predicting whether a branch will be taken (i.e., the condition will evaluate to true) or not taken (i.e., the condition will evaluate to false) is crucial for minimizing pipeline stalls and improving performance.When a branch instruction is encountered, the branch unit calculates the target address of the branch. This target address determines the location in the instruction stream where program execution will continue after the branch is resolved.

* <i><b>Control unit</i></b>

The Control Unit (CU) is a core component of the Central Processing Unit (CPU) responsible for coordinating and directing the operation of the entire processor. It interprets and executes instructions, directing the flow of data between the CPU's various functional units and external devices. The primary functions of the control unit include instruction decoding, instruction sequencing, and generating control signals to coordinate the operation of other CPU components.

* <i><b>Instruction Unit</i></b>

An instruction multiplexer (mux) is a component within a CPU's control unit responsible for selecting the next instruction to be executed from among multiple possible sources. It plays a crucial role in directing the flow of instruction execution within the CPU.Instruction muxes are often used at various stages of the CPU's instruction pipeline to select the appropriate instruction for each pipeline stage. This helps ensure that instructions are fetched and processed efficiently, minimizing pipeline stalls and improving overall CPU performance.

* <i><b>Write Enable Generator</i></b>

A write enable generator is a component within a computer system, often found in memory and input/output (I/O) interfaces, that generates signals to control when data can be written to a specific location in memory or when output data can be enabled for transmission.The write enable generator plays a crucial role in coordinating write operations in computer systems, ensuring that data is written or output only when appropriate and in a manner consistent with the system's operation.



* <i><b>Immediate Adder</i></b>

An immediate adder, also known as a constant adder or immediate arithmetic unit, is a component found within a CPU's arithmetic logic unit (ALU) that performs addition operations involving immediate values or constants.Immediate adders are commonly used in CPU architectures to perform arithmetic operations that involve immediate values, such as adding constants to variables or performing arithmetic with small fixed values. They play a crucial role in executing instructions efficiently, particularly in the context of arithmetic and logical operations with immediate operands.



* <i><b>Immediate Generator</i></b>

Immediate generators are essential for efficient execution of instructions that involve immediate operands, as they eliminate the need to access memory or registers to fetch these constants, thereby reducing latency and improving performance.

Constant Encoding: In some architectures, the immediate values are encoded directly within the instruction bits. The immediate generator decodes these encoded values and provides them to the execution units.

Sign Extension: For signed immediate values, the immediate generator may perform sign extension, which extends the sign bit of the immediate value to fill the full width of the operand, ensuring correct arithmetic operations.

Zero Extension: Similarly, for unsigned immediate values, the immediate generator may perform zero extension, which fills the unused bits with zeroes to match the operand width.

Shift and Masking: In some cases, the immediate generator may perform shifting or masking operations to adjust the immediate value according to the instruction's requirements.



* <i><b>Decoder Unit</i></b>

The decoder unit, also known as the instruction decoder, is a crucial component within the CPU that interprets and decodes instructions fetched from memory. Its primary function is to translate binary instructions into control signals that coordinate the operation of other CPU components, such as the ALU, registers, and memory units.The decoder unit receives the binary representation of instructions fetched from memory. It analyzes the opcode and any associated fields or parameters within the instruction to determine the type of operation to be performed and the operands involved.The decoder unit also plays a role in coordinating the sequencing of instructions within the CPU. It may generate signals to advance the Program Counter (PC) to the next instruction address, ensuring that instructions are executed in the correct sequence.

* <i><b>ALU Unit</i></b>

The Arithmetic Logic Unit (ALU) is a fundamental component of a CPU responsible for performing arithmetic and logical operations on data. It's a combinational circuit that takes input data from registers, performs the specified operation, and produces the result.

Inputs: The ALU receives operands from CPU registers or memory. These operands are the data on which the arithmetic or logical operation is to be performed. In some cases, the ALU may also receive control signals specifying the operation to be executed.

Operations: The ALU can perform a variety of operations, including addition, subtraction, AND, OR, XOR, shift operations (left shift, right shift), comparison (equality, less than, greater than), and more. The specific operation performed is determined by control signals received by the ALU.

Output: After performing the operation, the ALU produces a result, which is typically stored back in a register or sent to another part of the CPU for further processing. The output may also include status flags indicating the result of the operation, such as overflow, carry, zero, or negative flags.

Speed and Efficiency: ALUs are designed to perform operations quickly and efficiently, often using parallelism and pipelining techniques to maximize throughput. They are critical for the overall performance of the CPU, as many instructions executed by the CPU involve operations performed by the ALU.


* <i><b>Load unit</i></b>

 Load unit, also known as a load/store unit, is a component within a CPU responsible for handling load and store operations between the CPU and memory. Load operations involve transferring data from memory to CPU registers, while store operations involve transferring data from CPU registers to memory.Once the memory address is calculated, the load unit initiates a memory access operation to read or write data. This involves sending a request to the memory subsystem, specifying the memory address and the desired operation (read or write).The load unit is a critical component of the CPU's memory subsystem, responsible for efficiently transferring data between the CPU and memory. Its performance and efficiency significantly impact the overall performance of the CPU and system.







* <i><b>Store unit</i></b>

A "store unit" in a computer architecture context typically refers to the component responsible for performing store or write operations to memory. It's a part of the memory subsystem of a CPU and is involved in transferring data from registers or caches to memory.The store unit plays a crucial role in the memory subsystem of a CPU, facilitating the efficient transfer of data between the CPU and memory. Its performance and reliability are essential for the overall system performance and data integrity.



* <i><b>Write Back</i></b>

In computer architecture, "write back" typically refers to a memory access strategy used in caching systems, particularly in the context of cache coherence protocols and CPU cache management.
Cache Operation: In a CPU cache, data is typically stored in cache lines, each containing a block of memory. When the CPU reads data from memory, it first checks if the data is present in the cache. If the data is found in the cache (a cache hit), the CPU can retrieve it directly from the cache without accessing main memory, which is faster.

Write Operations: When the CPU needs to write data to memory, it first checks if the corresponding cache line containing the memory location is present in the cache. If the data is already in the cache, the CPU can update the cache line directly without accessing main memory. However, instead of immediately updating the main memory, the CPU may choose to update the cache line and mark it as "dirty" to indicate that it has been modified.

# <i><b> OUTPUT</i></b>

*  <i><b>R-Type </i></b>
R-type instructions operate on data stored in registers rather than directly on memory locations. The source registers provide the operands for the operation, and the result is stored in the destination register.<br>

R-type instructions have a fixed format that typically includes three fields:
</br>
- Opcode: Specifies the operation to be performed (e.g., addition, subtraction, bitwise AND).
- Source Register 1: Specifies the register containing the first operand.
- Source Register 2: Specifies the register containing the second operand.
- Destination Register: Specifies the register where the result of the operation will be stored.
R-type instructions are a fundamental aspect of RISC architectures, providing a streamlined and efficient mechanism for performing arithmetic and logical operations on data stored in registers. They play a central role in the design and implementation of RISC-based CPUs.


<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/fbeffdbb-717f-4b36-aad4-7b20a4092d91" width="720px" height=auto />
</p>

*  <i><b>I-Type </i></b>

I-type instructions, one operand is typically a value stored in a register, while the other operand is an immediate value encoded within the instruction itself. This immediate value is often used as a constant offset, address, or data value.

<br>I-type instructions typically have a fixed format that includes three fields:</br>
- Opcode: Specifies the operation to be performed (e.g., load, store, arithmetic, logical).
- Source Register: Specifies the register containing one of the operands.
- Immediate Value: Specifies a constant value used as the other operand. This value is encoded directly within the instruction.
- Destination Register: Specifies the register where the result of the operation will be stored.
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/dfb28c45-a9da-407c-a922-57173f3396a2" width="720px" height=auto />
</p>

*  <i><b>S-Type </i></b>

S-type instructions, the source register contains the data to be stored in memory. The memory address is calculated by adding an immediate offset value to the contents of a base register. This offset value is typically a constant encoded within the instruction itself.

<br>S-type instructions include:</br>
- Store Word (SW): Stores a word-sized data value from a register into memory at the address calculated using a base register and an immediate offset.
- Store Byte (SB): Stores a byte-sized data value from a register into memory at the address calculated using a base register and an immediate offset.
- Store Halfword (SH): Stores a halfword-sized data value from a register into memory at the address calculated using a base register and an immediate offset.
S-type instructions play a crucial role in enabling data transfer between registers and memory in RISC architectures, contributing to the efficiency and flexibility of program execution.

<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/dfcc355b-ca7d-4a6a-83b6-721eaba28747" width="720px" height=auto />
</p>

*  <i><b>B-Type </i></b>

B-type instructions, also known as Branch-type instructions, are a specific type of instruction format commonly found in instruction sets. B-type instructions are primarily used for altering the control flow of a program by specifying branches or jumps to different locations in the instruction sequence.
<br>B-type instructions include:</br>
- Unconditional Branch (B): Transfers control to the specified target address unconditionally.
- Conditional Branch (BEQ, BNE, BLT, etc.): Transfers control to the target address only if a certain condition is met (e.g., equality, inequality, less than).
 B-type instructions are essential for controlling program flow and implementing branching and decision-making logic in computer programs. They play a crucial role in enabling the execution of complex algorithms and control structures in software.

<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/55243375-73ea-4892-aa0d-0542f00367f3" width="720px" height=auto />
</p>

* <i><b>J-Type </i></b>

J-type instructions, also known as Jump-type instructions, are a specific type of instruction format commonly found in instruction sets. J-type instructions are primarily used for altering the control flow of a program by specifying unconditional jumps to different locations in the instruction sequence, typically to implement function calls, procedure returns, or long-distance branches.
<br>J-type instructions include:</br>
- Jump (J): Transfers control to the specified target address unconditionally. The target address is typically specified directly in the instruction.
- Jump and Link (JAL): Transfers control to the specified target address and saves the return address (the address of the next instruction) in a dedicated register, allowing for function calls and procedure returns.
J-type instructions are essential for controlling program flow and implementing jump and call operations in computer programs. They play a crucial role in enabling the execution of complex algorithms and control structures in software.

<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/6598d085-d010-473c-9bc0-b9fa3447f6f1" width="720px" height=auto />
</p>

* <i><b>U-type</i></b>

U-type instructions, the immediate value field contains a large immediate value that serves as the target address for the jump operation. Unlike J-type instructions, U-type instructions do not specify the target address directly in memory but encode it within the instruction itself.
<br> U-type instructions typically have a fixed format that includes two fields:
</br>
- Opcode: Specifies the operation to be performed (e.g., unconditional jump).
- Immediate Value: Specifies a large immediate value used as the target address for the jump. This value is encoded directly within the instruction itself.
- Unconditional Jump (UJ): Transfers control to the specified target address unconditionally. The target address is encoded directly within the instruction using a large immediate value.
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/c92f70a5-3d7f-4e5b-a928-5bb3577e30dc" width="720px" height=auto />
</p>


