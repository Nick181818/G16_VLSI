<i># STRV32I</i>
STRV32I is actually a RISC-v. RISC-V 32 refers to the 32-bit version of the RISC-V instruction set architecture (ISA). Like its 64-bit counterpart, RISC-V 32 is based on the principles of Reduced Instruction Set Computing (RISC).
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

a.	clk_in: System clock.

b.	rst_in: Active high and synchronous system reset.

2.	Instruction Cache Interface:

a.	imaddr_out: Carries 32-bit target address to icache.

b.	instr_in: 32-bit instruction fetched from icache.

3.	Data Cache Interface:

a.	dmwr_req_out: Write request signal to dcache, when high indicates a write request to dcache while being low it indicates a read request. This is a single bit signal.

b.	dmaddr_out: Carries the 32-bit target(read/write) address to dcache.

c.	dmdata_in: This is the 32-bit data read from dcache. During the Load.

d.	dmdata_out: This is the 32-bit data to be written to dcache. During the Store.

e.	dmwr_mask_out: This is a 4-bit mask signal that decides the bits to be masked during the dcache write operation.

# <i><b>INTRODUCTION</i></b>
Computers are built on specific architectural designs that dictate how instructions are executed and processed. Two primary architectures exist: Complex Instruction Set Computer (CISC) and Reduced Instruction Set Computer (RISC).

<i><b> RISC (Reduced Instruction Set Computer)</i></b>
RISC architecture, on the contrary, focuses on a reduced set of simple instructions, each typically executed in a single clock cycle. This simplicity results in faster execution and improved performance.
RISC architectures prioritize efficiency by favoring a smaller set of instructions, emphasizing faster instruction execution, and enabling better pipelining and parallelism. Notable RISC architectures include ARM and MIPS.

RISC-V stands as a cutting-edge open-source instruction set architecture (ISA) that embodies simplicity, adaptability, and versatility. Developed at the University of California, Berkeley, the RISC-V ISA was introduced in 2010 as an academic project aiming to address the limitations of existing architectures and provide a platform for innovation in computer architecture.

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

*	Openness and Accessibility: RISC-V's open-source nature democratizes access to the ISA, enabling innovation without licensing fees or restrictions.

*	Flexibility and Customizability: The modular design allows users to tailor solutions by incorporating custom instructions or extensions, fostering adaptability across diverse applications.

*	Scalability and Versatility: Supporting various versions like RV32I, RV64I, and RV128I, RISC-V addresses different performance needs and computing environments.

*	Elegance and Simplicity: RISC-V's streamlined design emphasizes a reduced instruction set, enhancing predictability, ease of implementation, and efficiency.
	
*	High Extensibility: A pivotal feature of RISC-V is its exceptional extensibility. This attribute enables users to expand the instruction set architecture by incorporating custom instructions or entire extensions. Its extensibility allows for the addition of new features, optimizations, and specialized functionalities, ensuring adaptability to evolving technological requirements and computing paradigms.

 

# <i><b>STRV32I STRCUTURE</i></b>

<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/7d9e10a2-418e-4214-86ed-4e2cbb0f1953" width="720px" height=auto />
</p>

# <i><b>OPERATION</i></b>
 * </i></b>PC Unit</i></b>:
The Program Counter is a register in a CPU that stores the memory address of the next instruction to be fetched and executed. It keeps track of the current position in the program's execution sequence.
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/bd0a19ad-5370-4b72-bf24-dd0e57978321" width="720px" height=auto />
</p>

* <i><b>Branch Unit</i></b>

One of the key functions of the branch unit is to predict the outcome of branch instructions before their execution. This prediction is based on various factors, such as the history of previous branches, the program counter (PC), and branch history tables. Predicting whether a branch will be taken (i.e., the condition will evaluate to true) or not taken (i.e., the condition will evaluate to false) is crucial for minimizing pipeline stalls and improving performance.When a branch instruction is encountered, the branch unit calculates the target address of the branch. This target address determines the location in the instruction stream where program execution will continue after the branch is resolved.

* <i><b>Control unit</i></b>

The Control Unit (CU) is a core component of the Central Processing Unit (CPU) responsible for coordinating and directing the operation of the entire processor. It interprets and executes instructions, directing the flow of data between the CPU's various functional units and external devices. The primary functions of the control unit include instruction decoding, instruction sequencing, and generating control signals to coordinate the operation of other CPU components.

* <i><b>Instruction Unit</i></b>

An instruction multiplexer (mux) is a component within a CPU's control unit responsible for selecting the next instruction to be executed from among multiple possible sources. It plays a crucial role in directing the flow of instruction execution within the CPU.Instruction muxes are often used at various stages of the CPU's instruction pipeline to select the appropriate instruction for each pipeline stage. This helps ensure that instructions are fetched and processed efficiently, minimizing pipeline stalls and improving overall CPU performance.

* <i><b>Write Enable Generator</i></b>

A write enable generator is a component within a computer system, often found in memory and input/output (I/O) interfaces, that generates signals to control when data can be written to a specific location in memory or when output data can be enabled for transmission.The write enable generator plays a crucial role in coordinating write operations in computer systems, ensuring that data is written or output only when appropriate and in a manner consistent with the system's operation.

<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/2fc9efe2-518d-466a-aa16-bd1fa1ac3784" width="720px" height=auto />
</p>


* <i><b>Immediate Adder<i><b>

An immediate adder, also known as a constant adder or immediate arithmetic unit, is a component found within a CPU's arithmetic logic unit (ALU) that performs addition operations involving immediate values or constants.Immediate adders are commonly used in CPU architectures to perform arithmetic operations that involve immediate values, such as adding constants to variables or performing arithmetic with small fixed values. They play a crucial role in executing instructions efficiently, particularly in the context of arithmetic and logical operations with immediate operands.


<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/be1b8bff-7fd4-4169-83d0-d05f0fdfb885" width="720px" height=auto />
</p>


* <i><b>Immediate Generator</i></b>

Immediate generators are essential for efficient execution of instructions that involve immediate operands, as they eliminate the need to access memory or registers to fetch these constants, thereby reducing latency and improving performance.

Constant Encoding: In some architectures, the immediate values are encoded directly within the instruction bits. The immediate generator decodes these encoded values and provides them to the execution units.

Sign Extension: For signed immediate values, the immediate generator may perform sign extension, which extends the sign bit of the immediate value to fill the full width of the operand, ensuring correct arithmetic operations.

Zero Extension: Similarly, for unsigned immediate values, the immediate generator may perform zero extension, which fills the unused bits with zeroes to match the operand width.

Shift and Masking: In some cases, the immediate generator may perform shifting or masking operations to adjust the immediate value according to the instruction's requirements.

<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/4e1d433f-a822-4599-9a84-f2af6685f7e9" width="720px" height=auto />
</p>


* <i><b>ALU Unit</i></b>
The Arithmetic Logic Unit (ALU) is a fundamental component of a CPU responsible for performing arithmetic and logical operations on data. It's a combinational circuit that takes input data from registers, performs the specified operation, and produces the result.

Inputs: The ALU receives operands from CPU registers or memory. These operands are the data on which the arithmetic or logical operation is to be performed. In some cases, the ALU may also receive control signals specifying the operation to be executed.

Operations: The ALU can perform a variety of operations, including addition, subtraction, AND, OR, XOR, shift operations (left shift, right shift), comparison (equality, less than, greater than), and more. The specific operation performed is determined by control signals received by the ALU.

Output: After performing the operation, the ALU produces a result, which is typically stored back in a register or sent to another part of the CPU for further processing. The output may also include status flags indicating the result of the operation, such as overflow, carry, zero, or negative flags.

Speed and Efficiency: ALUs are designed to perform operations quickly and efficiently, often using parallelism and pipelining techniques to maximize throughput. They are critical for the overall performance of the CPU, as many instructions executed by the CPU involve operations performed by the ALU.

<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/eeb3c389-f1cf-478a-99f3-d78ab34aef46" width="720px" height=auto />
</p>

* <i><b>Store unit</i></b>

A "store unit" in a computer architecture context typically refers to the component responsible for performing store or write operations to memory. It's a part of the memory subsystem of a CPU and is involved in transferring data from registers or caches to memory.The store unit plays a crucial role in the memory subsystem of a CPU, facilitating the efficient transfer of data between the CPU and memory. Its performance and reliability are essential for the overall system performance and data integrity.

<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/a3b1cdfa-335b-44ad-b994-fc91b3a81284" width="720px" height=auto />
</p>


* <i><b>Write Back</i></b>

In computer architecture, "write back" typically refers to a memory access strategy used in caching systems, particularly in the context of cache coherence protocols and CPU cache management.
Cache Operation: In a CPU cache, data is typically stored in cache lines, each containing a block of memory. When the CPU reads data from memory, it first checks if the data is present in the cache. If the data is found in the cache (a cache hit), the CPU can retrieve it directly from the cache without accessing main memory, which is faster.

Write Operations: When the CPU needs to write data to memory, it first checks if the corresponding cache line containing the memory location is present in the cache. If the data is already in the cache, the CPU can update the cache line directly without accessing main memory. However, instead of immediately updating the main memory, the CPU may choose to update the cache line and mark it as "dirty" to indicate that it has been modified.

# OUTPUT

# WAVEFORM
