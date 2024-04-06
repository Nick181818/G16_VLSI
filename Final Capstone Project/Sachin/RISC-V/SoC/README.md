**RISC-V PROCESSOR**

-	RISC-V is a modern take on the Reduced Instruction Set Computer (RISC) design philosophy.

*	It is designed to address the limitations and challenges of previous RISC architectures.

+	RISC-V draws inspiration from earlier RISC architectures, such as the MIPS, SPARC, and ARM architectures.


**WHY RISC-V?**

	- Open Standard (Free ISA)
	- Reduced complexity
	- Customization and Extensibility


**CONTENTS**

		- DESIGN SPECIFICATIONS
		- CPI CALCULATION
		- INTERFACE DETAILS
		- RISC-V ARCHITECTURE DATAPATH
		
**<DESIGN SPECIFICATIONS>**

*Design a 3-stage pipelined RISC-V processor that works on RV32I ISA- STRV32I.*

<p align = "center">
  <img src="https://github.com/Sachind01/G16/assets/114092614/20f39fbe-1536-48d2-b681-a8aa9f312b29" width="720px" Height="auto">
</p>


**<CPI CALCULATION>**

To calculate the CPI (Cycles Per Instruction) for a RISC-V 3-staged pipeline, we need to consider the following stages:

	1. Instruction Fetch (IF)
	2. Instruction Decode/Register File Read (ID/RF)
	3. Execute/Memory Access/Write Back (EX/MEM/WB)

Assuming a perfect pipeline with no stalls or hazards, the CPI for a 3-staged pipeline would be:

	CPI=\frac{Total\ Cycles}{Total\ Instructions}

In a 3-stage pipeline, assuming no stalls, each instruction takes 3 cycles to execute. However, if there are stalls due to hazards, the CPI will increase.

If we assume there are no hazards, each instruction will take 3 cycles, so CPI = 3.

If we need to factor in hazards, the CPI will increase accordingly. For example, if 20% of instructions encounter a stall of 1 cycle due to a hazard, then the CPI would be:

	CPI=\frac{(0.20\times4)\ +\ (0.80\times3)}{1}\ =\ 3.20



**Interface Details:**

**<General Interface:>**

clk_in: System clock (10Mhz).

rst_in: Active high and synchronous system reset.

**<Instruction Cache Interface:>**

imaddr_out: Carries 32-bit target address to icache.

instr_in: 32-bit instruction fetched from icache.

Data Cache Interface:
dmwr_req_out: Write request signal to dcache, when high indicates a write request to dcache while being low it indicates a read request. This is a single bit signal.

dmaddr_out: Carries the 32-bit target(read/write) address to dcache.

dmdata_in: This is the 32-bit data read from dcache. During the Load.

dmdata_out: This is the 32-bit data to be written to dcache. During the Store.

dmwr_mask_out: This is a 4-bit mask signal that decides the bits to be masked during the dcache write operation.

**<RISC-V INSTRUCTIONS>**


* R-Type Instructions:
	
		R-Type instructions perform register-to-register operations, where the operands and the destination are all registers. These instructions are typically used for arithmetic, logical, and shift operations.

		Example: `add x3, x1, x2` (adds the values in registers x1 and x2, and stores the result in register x3)

* I-Type Instructions:
	
	
		I-Type instructions perform operations between a register and an immediate (constant) value. These instructions are commonly used for arithmetic operations, loads, and other data transfer operations.

	
		Example: `addi x5, x6, 10` (adds the value in register x6 with the immediate value 10, and stores the result in register x5)

*  S-Type Instructions:

		S-Type instructions are used for storing values from registers to memory addresses. They involve a base register, an immediate offset, and a source register.


		Example: `sw x7, 8(x8)` (stores the value in register x7 to the memory address calculated by adding 8 to the value in register x8)

*	 B-Type Instructions:
	
	
		
			B-Type instructions are conditional branch instructions that change the control flow of the program based on a comparison between two registers or a register and an immediate value.

			Example: `beq x9, x10, label` (branches to the specified label if the values in registers x9 and x10 are equal)

* J-Type Instructions:

		J-Type instructions are unconditional jump instructions that transfer control to a new address specified by an immediate value.

		Example: `jal x11, func` (jumps to the address of the func label, and stores the return address in register x11)

*  U-Type Instructions:
		
		U-Type instructions are used for loading upper immediate values into registers, typically for generating addresses or immediate values larger than those supported by I-Type instructions.

		Example: `lui x12, 0x10000` (loads the upper 20 bits of the immediate value 0x10000 into register x12, effectively setting the register to 0x10000000)

These instruction types provide a comprehensive set of operations for arithmetic, data transfer, control flow, and memory access, enabling the RISC-V architecture to support a wide range of applications and workloads.


**To ensure code quality and adherence to best practices, linting was performed on the STRV32I processor design codebase, which helps catch potential errors, enforces coding standards, and improves code maintainability.**


**<RISC-V STRV32I SCHEMATIC>

<p align = "center">

  <img src="https://github.com/Sachind01/G16/assets/114092614/431958ff-7578-43e5-ac78-51fac4549975" width="720px" Height="auto">
</p>

<PDF FILE OF SCHEMATIC>	
<p align = "center">
  <img src="https://github.com/Sachind01/G16/files/14892273/schematic.pdf" width="720px" Height="auto">
</p>