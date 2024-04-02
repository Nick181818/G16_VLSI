# STRV32I
STRV32I is actually a RISC-v. RISC-V 32 refers to the 32-bit version of the RISC-V instruction set architecture (ISA). Like its 64-bit counterpart, RISC-V 32 is based on the principles of Reduced Instruction Set Computing (RISC).
RISC-V 32 is a version of the RISC-V instruction set architecture that operates with 32-bit data and addresses. It  prioritizes simplicity and efficiency in processor design. RISC-V 32, like its 64-bit counterpart, is modular, open-source, and allows for optional extensions to support specific functionalities. It's suitable for a wide range of applications, from embedded systems to smartphones, offering versatility and flexibility.



# CONTENT
* DESIGN SPECIFICATIONS
* INTRODUCTION
* STRV32I STRCUTURE
* OPERATION
* OUTPUT
* WAVEFORM

# DESIGN SPECIFICATIONS
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

# INTRODUCTION
Computers are built on specific architectural designs that dictate how instructions are executed and processed. Two primary architectures exist: Complex Instruction Set Computer (CISC) and Reduced Instruction Set Computer (RISC).

RISC (Reduced Instruction Set Computer)
RISC architecture, on the contrary, focuses on a reduced set of simple instructions, each typically executed in a single clock cycle. This simplicity results in faster execution and improved performance.
RISC architectures prioritize efficiency by favoring a smaller set of instructions, emphasizing faster instruction execution, and enabling better pipelining and parallelism. Notable RISC architectures include ARM and MIPS.

RISC-V stands as a cutting-edge open-source instruction set architecture (ISA) that embodies simplicity, adaptability, and versatility. Developed at the University of California, Berkeley, the RISC-V ISA was introduced in 2010 as an academic project aiming to address the limitations of existing architectures and provide a platform for innovation in computer architecture.

 #### RISC architecture consists of a series of stages that an instruction goes through during its execution:
1.	Instruction Fetch: The CPU fetches the instruction from memory.
2.	Decode: The instruction is decoded to determine the operation to be performed.
3.	Execute: The CPU executes the operation specified by the instruction.
4.	Memory Access: If necessary, the CPU accesses memory to read or write data.
5.	Write Back: The CPU writes the results of the operation back to the appropriate register or memory location.

<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/1cc47fd0-adef-4424-8697-46ae7f6f82f6" width="720px" height=auto />
</p>


#### 2.1.3	Advantages of RISC-V
RISC-V stands as a beacon in modern computing due to its revolutionary features and adaptable nature, encompassing several advantages:

*	Openness and Accessibility: RISC-V's open-source nature democratizes access to the ISA, enabling innovation without licensing fees or restrictions.

*	Flexibility and Customizability: The modular design allows users to tailor solutions by incorporating custom instructions or extensions, fostering adaptability across diverse applications.

*	Scalability and Versatility: Supporting various versions like RV32I, RV64I, and RV128I, RISC-V addresses different performance needs and computing environments.

*	Elegance and Simplicity: RISC-V's streamlined design emphasizes a reduced instruction set, enhancing predictability, ease of implementation, and efficiency.
	
*	High Extensibility: A pivotal feature of RISC-V is its exceptional extensibility. This attribute enables users to expand the instruction set architecture by incorporating custom instructions or entire extensions. Its extensibility allows for the addition of new features, optimizations, and specialized functionalities, ensuring adaptability to evolving technological requirements and computing paradigms.

 

# STRV32I STRCUTURE

<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/7d9e10a2-418e-4214-86ed-4e2cbb0f1953" width="720px" height=auto />
</p>

# OPERATION
 * PC Unit:
The Program Counter is a register in a CPU that stores the memory address of the next instruction to be fetched and executed. It keeps track of the current position in the program's execution sequence.
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/bd0a19ad-5370-4b72-bf24-dd0e57978321" width="720px" height=auto />
</p>

Write Enable Generator
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/2fc9efe2-518d-466a-aa16-bd1fa1ac3784" width="720px" height=auto />
</p>


Immd adder
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/be1b8bff-7fd4-4169-83d0-d05f0fdfb885" width="720px" height=auto />
</p>


immed generator
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/4e1d433f-a822-4599-9a84-f2af6685f7e9" width="720px" height=auto />
</p>


ALU Unit
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/eeb3c389-f1cf-478a-99f3-d78ab34aef46" width="720px" height=auto />
</p>

Store unit

<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/a3b1cdfa-335b-44ad-b994-fc91b3a81284" width="720px" height=auto />
</p>



# OUTPUT

# WAVEFORM
