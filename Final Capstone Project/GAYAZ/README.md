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


* <i><b>Branch Unit</i></b>

* <i><b>Control unit</i></b>

* <i><b>Instruction Unit</i></b>


* <i><b>Write Enable Generator</i></b>



* <i><b>Immediate Adder</i></b>



* <i><b>Immediate Generator</i></b>

* <i><b>Decoder Unit</i></b>

* <i><b>ALU Unit</i></b>


* <i><b>Load unit</i></b>


* <i><b>Store unit</i></b>


# <i><b> OUTPUT</i></b>

*  <i><b>R-Type </i></b>
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/fbeffdbb-717f-4b36-aad4-7b20a4092d91" width="720px" height=auto />
</p>

*  <i><b>I-Type </i></b>
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/dfb28c45-a9da-407c-a922-57173f3396a2" width="720px" height=auto />
</p>

*  <i><b>S-Type </i></b>
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/dfcc355b-ca7d-4a6a-83b6-721eaba28747" width="720px" height=auto />
</p>

*  <i><b>B-Type </i></b>
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/55243375-73ea-4892-aa0d-0542f00367f3" width="720px" height=auto />
</p>

* <i><b>J-Type </i></b>
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/6598d085-d010-473c-9bc0-b9fa3447f6f1" width="720px" height=auto />
</p>

* U-type
<p align ="center">
 <img src="https://github.com/GayazPatan/Images/assets/156210984/c92f70a5-3d7f-4e5b-a928-5bb3577e30dc" width="720px" height=auto />
</p>


