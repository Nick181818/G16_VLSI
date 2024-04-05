# MAJOR PROJECT  
## STRV32I  
Design a 3-stage pipelined RISC-V processor that works on RV32I ISA- STRV32I.  

 #Interface Details  
 1.General Interface:  
   a. clk_in: System clock (10Mhz).  
   b. rst_in: Active high and synchronous system reset.  
   2. Instruction Cache Interface:  
   a. imaddr_out: Carries 32-bit target address to icache.  
   b. instr_in: 32-bit instruction fetched from icache.  
   3. Data Cache Interface:  
   a. dmwr_req_out: Write request signal to dcache, when high indicates a write request to dcache while being low it indicates a read request. This is a single bit signal.  
   b. dmaddr_out: Carries the 32-bit target(read/write) address to dcache.  
   c. dmdata_in: This is the 32-bit data read from dcache. During the Load.  
   d. dmdata_out: This is the 32-bit data to be written to dcache. During the Store.  
   e. dmwr_mask_out: This is a 4-bit mask signal that decides the bits to be masked during the dcache write operation.  

----->Top_module  
----->PC_MUX  
----->reg_block  
----->immediate_adder  
----->write_enable_generator  
----->control_unit  
----->immediate_generator  
----->reg_file  
----->instruction_mux  
----->branch_unit  
----->load_unit  
----->store_unit  
----->decoder_unit  
----->ALU_block  
----->reg_block2  
----->wb_mux  
----->processor_tb    
 ### PC_MUX
 ● Decide next PC value.  
 ● As here each memory location is of 32 bits so every time, under normal circumstances, PC get incremented by 4  
  ● If any misalign instr. comes then for that we have misaligned_instr_out  
  ● If reset then the value of PC becomes 0000H  
  ● In the case of Branch or Jump instr. we have to jump at a new location, ( for which immediate value is offset to PC) for that we have i_addr_o.  

<img src="https://github.com/M-Suryanarayana/fifo/assets/156163346/e71261f1-7903-4c28-96b7-e1d1be33aa5d" width="720px" Height="auto">
</p>  
<img src="https://github.com/M-Suryanarayana/fifo/assets/156163346/0c2ad2ae-419b-41b5-9abb-47859a840620" width="720px" Height="auto">
</p>  
<img src="https://github.com/M-Suryanarayana/fifo/assets/156163346/28e9fc59-8022-4dfb-997f-bbb278a0b62d" width="720px" Height="auto">
</p>   
<img src="https://github.com/M-Suryanarayana/fifo/assets/156163346/ccdab13d-2a93-40ad-bc5b-3924d93bb301" width="720px" Height="auto">
</p>   
<img src="https://github.com/M-Suryanarayana/fifo/assets/156163346/e01d71b0-c8d1-449c-bd51-0316f325291b" width="720px" Height="auto">
</p>   
<img src="https://github.com/M-Suryanarayana/fifo/assets/156163346/201c3937-ae96-42de-bc79-637fda8f9d91" width="720px" Height="auto">
</p>   
## Reg_block1  
● It is used for synchronization purpose so that all the signals of stage 1 pass through it so that they are able to reach 2nd stage in 2nd clock cycle  

<img src="https://github.com/M-Suryanarayana/fifo/assets/156163346/bebd53a8-bd5e-4f32-b41a-f4085a4521d3" width="720px" Height="auto">
</p>  
## imm_adder  
 ● It takes the PC_in and adds it with the immediate value produced by immediate generator and hence successfully generates new value of PC  

<img src="https://github.com/M-Suryanarayana/fifo/assets/156163346/e269330f-1bbb-4b2a-823c-8df483c4f58c" width="720px" Height="auto">
</p>   
##  wr_en_generator  
● It generates the write enable signals, which will decide whether we can access the register file for writing / updating any value  

<img src="https://github.com/M-Suryanarayana/fifo/assets/156163346/d364f7af-2ca2-47f4-a25b-a7075fca912b" width="720px" Height="auto">
</p>  
<img src="https://github.com/M-Suryanarayana/fifo/assets/156163346/0d105829-947d-4635-92d2-76315ddb5867" width="720px" Height="auto">
</p>   
<img src="https://github.com/M-Suryanarayana/fifo/assets/156163346/597d3fc4-6b37-44eb-8dac-11dcbba8486b" width="720px" Height="auto">
</p>    
waveform_1  
<img src="https://github.com/M-Suryanarayana/fifo/assets/156163346/71145371-14ee-4450-b5ae-1a83ce4a6399" width="720px" Height="auto">
</p>  
waveform_2  
<img src="https://github.com/M-Suryanarayana/fifo/assets/156163346/17563065-5231-4b19-8305-763443385bf1" width="720px" Height="auto">
</p>   
waveform_3  
<img src="https://github.com/M-Suryanarayana/fifo/assets/156163346/78be9148-7800-4ffc-9a0e-f57c645332d8" width="720px" Height="auto">
</p> 


