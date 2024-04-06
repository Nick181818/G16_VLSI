  

  # Instructions 

  #### Instructions are taken from the ripes software


  # Alp Program for the Instructions
  ```
    add x28, x12, x13 //R-Type
    addi x10, x11, 2 //I-Type
    sh x12, 0x6(x10) //S-Type
    lw x13, 0x6(x10) //S-Type
    bltu x10, x12, 0x14 //B-Type
    jalr x10, x12, 0x1 //J-Type
    lui x12, 0x12345 //U-Type

  ```
  
  ```

    //R-Type Instruction 
    instruct_memory[0]	=	32'h00d60e33;
    //I-Type Instruction 
    instruct_memory[4]	=	32'h00258513;
    //S-Type Instruction {shift}
    instruct_memory[8]	=	32'h00c51323;
    //S-Type Instruction {lw}
    instruct_memory[12]	=	32'h00652683;
    //B-Type Instruction
    instruct_memory[16]	=	32'h00c56a63;
    //J-Type
    instruct_memory[20]	=	32'h00160567 ;
    //U-Type
    instruct_memory[24]	=	32'h12345637;

    ```