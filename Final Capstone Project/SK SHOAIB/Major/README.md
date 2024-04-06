# *3 - Stage Pipelined RISC-V Processor - Major Project*

This project is about design of RISC-V Processor that works on the RV32I ISA with the following interfaces :

-  ### *General Interface :*
    - $clk$ _ $in$ $:$ $System$ $clock$ $(10MHz)$
    - $rst$ _ $in$ $:$ $Active$ $high$ $and$ $synchronous$ $system$ $reset$
- ### *Instruction Cache Interface :*
   - $im$ _ $addr$ _ $out$ $:$ $Carries$ $32$ - $bit$ $target$ $address$ $to$ $icache$
   - $instr$ _ $in$ $:$ $32$ - $bit$ $instruction$ $fetched$ $from$ $icache$
- ### *Data Cache Interface :*
   - $dm$ _ $wr$ _ $req$ _ $out$ $:$ $Write$ $request$ $signal$ $to$ $dcache,$ 
     - $When$ $high$ $indicates$ $a$ $write$
$request$ $to$ $dcache$ 
     - $When$ $low$ $it$ $indicates$ $a$ $read$ $request$ $($ $This$ $is$ $a$ $single$ $bit$ $signal$ $)$
   - $dm$ _ $addr$ _ $out$ $:$ $Carries$ $the$ $32$ - $bit$ $target$ $($ $read$ $/$ $write$ $)$ $address$ $to$ $dcache$
   - $dm$ _ $data$ _ $in$ $:$ $This$ $is$ $the$ $32$ - $bit$ $data$ $read$ $from$ $dcache$ $during$ $the$ $load$
   - $dm$ _ $data$ _ $out$ $:$ $This$ $is$ $the$ $32$ - $bit$ $data$ $to$ $be$ $written$ $to$ $dcache$ $during$ $the$
$store$
   - $dm$ _ $wr$ _ $mask$ _ $out$ $:$ $This$ $is$ $a$ $4$ - $bit$ $mask$ $signal$ $that$ $decides$ $the$ $bits$ $to$ $be$
$masked$ $during$ $the$ $dcache$ $write$ $operation$

### *Design Details :*

Inputs and Output to RISC - V


|  Port Name      | Direction |  Type  |   Description                |
|-----------------|-----------|--------|------------------------------|
|  clk_in         |   input   |        | System Clock                 |
|  rst_in         |   input   |        | System Reset                 |
|  dm_data_in     |   input   | [31:0] | Data input from dcache       |
|  instr_in       |   input   | [31:0] | Instruction input from icache|
|  dm_wr_req_out  |   output  |        | Write request to dcache      |
|  im_addr_out    |   output  | [31:0] | Address output to icache     |
|  dm_addr_out    |   output  | [31:0] | Address output to dcache     |
|  dm_data_out    |   output  | [31:0] | Data output to dcache        |
|  dm_wr_mask_out |   output  | [3:0]  | Mask bits to dcache          |


### *Block Diagram*

<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/d08de6e2-7b3d-4d04-9782-912727118738" width="500">
</p>

### *Reference Architecture*



<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/5b4bfb79-06e2-41f8-96b7-814f7d6f73e6" width="500">
</p>


## *Introduction to RISC Architecture*

### *General Computer Architecture :*
- $Computers$ $are$ $built$ $on$ $specific$ $architectural$ $designs$ $that$ $dictate$ $how$ $instructions$ $are$ $executed$ $and$ $processed$
- $There$ $are$ $two$ $primary$ $architectures$ $exist$ $:$ 
   - $Complex$ $Instruction$ $Set$ $Computer$ $(CISC)$
   - $Reduced$ $Instruction$ $Set$ $Computer$ $(RISC)$

### *CISC (Complex Instruction Set Computer) :*
-  $CISC$ $architecture$ $is$ $characterized$ $by$ $an$ $extensive$ $set$ $of$ $complex$ $instructions$ $capable$ $of$ $performing$ $multifaceted$ $operations$ $within$ $a$ $single$ $instruction$
- $These$ $instructions$ $are$ $often$ $variable$ $in$ $length$ $and$ $can$ $require$ $multiple$ $clock$ $cycles$ $for$ $execution$
- $CISC$ $architectures$ $historically$ $evolved$ $to$ $handle$ $various$ $complex$ $operations$ $within$ $a$ $single$ $instruction$, $aiming$ $to$ $simplify$ $programming$
   - $Examples$ $:$ $Intel$ $x86$ $and$ $AMD$ $Processors$

### *RISC (Reduced Instruction Set Computer) :*
-  $RISC$ $architecture$, $on$ $the$ $contrary$, $focuses$ $on$ $a$ $reduced$ $set$ $of$ $simple$ $instructions$, $each$ $typically$ $executed$ $in$ $a$ $single$ $clock$ $cycle$
- $This$ $simplicity$ $results$ $in$ $faster$ $execution$ $and$ $improved$ $performance$
- $RISC$ $architectures$ $prioritize$ $efficiency$ $by$ $favoring$ $a$ $smaller$ $set$ $of$ $instructions$, $emphasizing$ $faster$ $instruction$ $execution$, $and$ $enabling$ $better$ $pipelining$ $and$ $parallelism$
   - $Notable$ $RISC$ $architectures$ $include$ $ARM$ $and$ $MIPS$

###  *Difference between RISC and CISC*
-  $Instruction$ $Set$ $:$ 
   - $CISC$ $architectures$ $have$ $a$ $larger$ $and$ $more$ $complex$ $instruction$ $set$, $while$ $RISC$ $architectures$ $have$ $a$ $smaller$ $and$ $simpler$ $instruction$ $set$

 - $Instruction$ $Execution$ $:$
   - $RISC$ $architectures$ $typically$ $execute$ $instructions$ $in$ $fewer$ $clock$ $cycles$ $compared$ $to$ $CISC$ $architectures$ $due$ $to$ $their$ $simpler$ $design$

 - $Load$ - $Store$ $Architecture$ $in$ $RISC$ $:$ 
   - $One$ $notable$ $characteristic$ $of$ $RISC$ $architecture$ $is$ $the$ $Load$ - $Store$ $architecture$. $In$ $RISC$, $only$ $load$ $and$ $store$ $instructions$ $can$ $access$ $memory$, $while$ $all$ $other$ $operations$ $are$ $performed$ $using$ $registers$. $This$ $architecture$ $minimizes$ $memory$ $access$, $improving$ $performance$ $by$ $reducing$ $the$ $number$ $of$ $memory$ - $related$ $instructions$

## *RISC - V*
- $RISC$ - $V$ $stands$ $as$ $a$ $cutting$ - $edge$, $open$ - $source$ $instruction$ $set$ $architecture$ $(ISA)$ $that$ $embodies$ $simplicity$, $adaptability$, $and$ $versatility$

- $It$ $was$ $developed$ $at$ $the$ $University$ $of$ $California$, $Berkeley$

- $RISC$ - $V$ $ISA$ $was$ $introduced$ $in$ $2010$ $as$ $an$ $academic$ $project$ $aiming$ $to$ $address$ $the$ $limitations$ $of$ $existing$ $architectures$ $and$ $provide$ $a$ $platform$ $for$ $innovation$ $in$ $computer$ $architecture$

### *Stages :*
- $Instruction$ $Fetch$ $:$ $The$ $CPU$ $fetches$ $the$ $instruction$ $from$ $memory$
- $Instruction$ $Decode$ $:$ $The$ $instruction$ $is$ $decoded$ $to$ $determine$ $what$ $operation$ $is$ $to$ $be$ $performed$
- $Instruction$ $Execute$ $:$ $The$ $CPU$ $executes$ $the$ $operation$ $specified$ $by$ $the$ $instruction$
- $Memory$ $Access$ $:$ $If$ $necessary$, $the$ $CPU$ $accesses$ $memory$ $to$ $read$ $or$ $write$ $data$
- $Write$ $Back$ $:$ $The$ $CPU$ $writes$ $the$ $results$ $of$ $the$ $operation$ $back$ $to$ $the$ $appropriate$ $register$ $or$ $memory$ $location$

### *Datapath*


<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/3843b41e-7e0c-4b5f-9d85-85410721d787" width="500">
</p>

### *Advantages :*
- $Openness$ $and$ $Accessibility$ $:$ 
  -  $RISC$ - $V's$ $open$ - $source$ $nature$ $democratizes$ $access$ $to$ $the$ $ISA$, $enabling$ $innovation$ $without$ $licensing$ $fees$ $or$ $restrictions$
- $Scalability$ $and$ $Versatility$ $:$ 
  - $Supporting$ $various$ $versions$ $like$ $RV32I$, $RV64I$, $and$ $RV128I$, $RISC$ - $V$ $addresses$ $different$ $performance$ $needs$ $and$ $computing$ $environments$
- $Elegance$ $and$ $Simplicity$ $:$ 
  - $RISC$ - $V's$ $streamlined$ $design$ $emphasizes$ $a$ $reduced$ $instruction$ $set$, $enhancing$ $predictability$, $ease$ $of$ $implementation$ $and$ $efficiency$
- $High$ $Extensibility$ $:$ 
  - $The$ $pivotal$ $feature$ $of$ $RISC$ - $V$ $is$ $its$ $exceptional$ $extensibility$. $Its$ $allows$ $for$ $the$ $addition$ $of$ $new$ $features$,$optimizations$ $and$ $specialized$ $functionalities$, $ensuring$ $adaptability$ $to$ $evolving$ $technological$ $requirements$ $and$ $computing$ $paradigms$

## *Pipelining*
-  $Pipelining$ $is$ $a$ $CPU$ $optimization$ $technique$ $that$ $enhances$ $processor$ $performance$ $by$ $overlapping$ $multiple$ $instructions$ $execution$ $concurrently$ 
- $It$ $divides$ $the$ $instruction$ $execution$ $into$ $discrete$ $stages$, $where$ $different$ $stages$ $operate$ $in$ $parallel$, $enabling$ $the$ $processor$ $to$ $execute$ $multiple$ $instructions$ $simultaneously$    
- $This$ $segmentation$ $enables$ $different$ $instructions$ to be $processed$ $concurrently$, $ideally$ $leading$ $to$ increased $throughput$ $and$ $overall$ $performance$

### *Working :*
- $Instruction$ $Fetch$ $(IF)$ $:$ $Fetches$ $the$ $next$ $instruction$ $from$ $memory$
- $Instruction$ $Decode$ $(ID)$ $:$ $Decodes$ $the$ $instruction$ $to$ $determine$ $which$ $operation$ $is$ $to$ $be$ $performed$
- $Instruction$ $Execute$ $(EX)$ $:$ $Performs$ $the$ $actual$ $operation$ $specified$ $by$ $the$ $instruction$
- $Memory$ $Access$ $(ME)$ $:$ $If$ $needed$, $accesses$ $memory$ $to$ $ead$ $or$ $write$ $data$
- $Write$ $Back$ $(WB)$ $:$ $Write$ $the$ $results$ $of$ $the$ $operation$ $back$ $to$ $the$ $appropriate$ $register$ $or$ $memory$ $location$

### *Why Pipelining* 

<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/3370c4ee-7472-465a-862d-4ddf897b29b3" width="500">
</p>
<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/1a064c08-950b-4760-b2f0-c0246fbca1df" width="500">
</p>



### *Advantages :*
- $Increased$ $Throughput$ $:$ 
  - $Pipelining$ $enables$ $multiple$ $instructions$ $to$ $be$ $processed$ $simultaneously$, $enhancing$ $the$ $overall$ $throughput$ $of$ $the$ $CPU$
- $Improved$ $Efficiency$ $:$ 
  - $Concurrent$ $execution$ $of$ $instructions$ $reduces$ $idle$ $time$ $in$ $the$ $CPU$, $making$ $better$ $use$ $of$ $resources$
- $Enhanced$ $Performance$ $:$
  - $By$ $breaking$ $down$ $instruction$ $execution$ $into$ $smaller$ $stages$, $pipelining$ $speeds$ $up$ $the$ $overall$ $execution$ $of$ $instructions$
- $Resource$ $Utilization$ $:$ 
  - $It$ $allows$ $the$ $CPU$ $to$ $operate$ $at$ $a$ $higher$ $clock$ $frequency$ $by$ $leveraging$ $parallel$ $processing$, $thereby$ $utilizing$ $resources$ $more$ $efficiently$

### *Disadvantages :*
- $Pipeline$ $Stall$ $:$ 
  - $Dependencies$ $between$ $instructions$ $or$ $unforeseen$ $conditions$ $can$ $lead$ $to$ $pipeline$ $stalls$, $causing$ $delays$ $and$ $reducing$ $overall$ $performance$
- $Resource$ $Conflicts$ $:$
  - $Access$ $to$ $shared$ $resources$ $by$ $multiple$ $pipeline$ $stages$ $can$ $result$ $in$ $conflicts$, $leading$ $to$ $contention$ $and$ $performance$ $degradation$
- $Complexity$ $in$ $Handling$ $Hazards$ $:$
  - $Pipelining$ $introduces$ $hazards$ $like$ $data$ $hazards$, $control$ $hazards$, $and$ $structural$ $hazards$, $requiring$ $specialized$ $handling$ $techniques$, $such$ $as$ $forwarding$ $or$ $stalling$, $which$ $can$ $increase$ $complexity$

## *3-Stage Pipelined RISC Data Path*
A 3-stage pipelined RISC data path divides the instruction execution into three distinct stages :
- $Instruction$ $Fetch$ $(IF)$ $:$ $Fetches$ $the$ $next$ $instruction$ $from$ $memory$
- $Instruction$ $Decode$ $(ID)$ $:$ $Decodes$ $the$ $instruction$ $to$ $determine$ $the$ $operation$ $to$ $be$ $performed$ $and$ $the$ $operands$
- $Execute$ $(EX)$, $Memory$ $Access$ $(ME)$, $Write$ $Back$ $(WB)$ $:$ $These$ $stages$ $are$ $merged$ $into$ $a$ $single$ $stage$ $in$ $the$ $3$ - $stage$ $pipeline$ $architecture$

### *Datapath*

<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/897b2601-cf17-4151-856c-e1ef6129009a" width="500">
</p> 

## *Waveforms*

### *R - Type :*

- $Instruction$ $:$ $add$ $x0$, $x3$, $x4$

- $As$ $per$ $the$ $ISA$,
   - $Hex$ $equivalent$   $:$  $00418033$
   - $Bin$ $equivalent$   $:$ $00000000010000011000000000110011$
   - $Opcode$             $:$ $011$ _ $0011$
   - $funct3$             $:$ $3'b000$
   - $funct7$             $:$ $7'b000$ _ $0000$
   - $rs1$ _ $addr$       $:$ $5'h3$
   - $rs2$ _ $addr$       $:$ $5'h4$
   - $rd$ _ $addr$        $:$ $5'h0$

### *Tool Simulation :*

<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/5a5a3cb8-6d77-41e8-8ae8-2e0aa5d6023b" width="800">
</p> 




### *I - Type :*
- $Instruction$ $:$ $addi$ $x1$, $x5$, $7$

- $As$ $per$ $the$ $ISA$,
   - $Hex$ $equivalent$   $:$  $00728093$
   - $Bin$ $equivalent$   $:$ $00000000011100101000000010010011$
   - $Opcode$             $:$ $001$ _ $0011$
   - $funct3$             $:$ $3'b000$
   - $funct7$             $:$ $7'b000$ _ $0000$
   - $rs1$ _ $addr$       $:$ $5'h5$
   - $rs2$ _ $addr$       $:$ $5'h7$
   - $rd$ _ $addr$        $:$ $5'h1$

### *Tool Simulation :*

<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/e3829641-5a7c-4a1b-9596-d5ada63457e9" width="800">
</p> 



### *S - Type :*

- $Instruction$ $:$ $sh$ $x10$, $0x7$ $(x9)$

- $As$ $per$ $the$ $ISA$,
   - $Hex$ $equivalent$   $:$  $00a493a3$
   - $Bin$ $equivalent$   $:$ $00000000101001001001001110100011$
   - $Opcode$             $:$ $010$ _ $0111$
   - $funct3$             $:$ $3'b001$
   - $funct7$             $:$ $7'b000$ _ $0000$
   - $rs1$ _ $addr$       $:$ $5'h9$
   - $rs2$ _ $addr$       $:$ $5'ha$
   - $rd$ _ $addr$        $:$ $5'h7$


### *Tool Simulation :*

<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/1863c115-893d-4bb4-8c1d-930ced949d53" width="800">
</p> 

 ### *L - Type :*
- $Instruction$ $:$ $lw$ $x10$, $0x5$ $(x6)$
- $As$ $per$ $the$ $ISA$,
   - $Hex$ $equivalent$   $:$  $00532503$
   - $Bin$ $equivalent$   $:$ $00000000010100110010010100000011$
   - $Opcode$             $:$ $000$ _ $0011$
   - $funct3$             $:$ $3'b010$
   - $funct7$             $:$ $7'b000$ _ $0000$
   - $rs1$ _ $addr$       $:$ $5'h6$
   - $rs2$ _ $addr$       $:$ $5'h5$
   - $rd$ _ $addr$        $:$ $5'ha$


### *Tool Simulation :*
<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/771a6b20-ae2b-490f-b0e4-a210181bab50" width="800">
</p> 

### *B - Type :*
- $Instruction$ $:$ $bltu$ $x9$, $x10$, $0x10$

- $As$ $per$ $the$ $ISA$,
   - $Hex$ $equivalent$   $:$  $00a4e863 $
   - $Bin$ $equivalent$   $:$ $00000000101001001110100001100011$
   - $Opcode$             $:$ $110$ _ $0011$
   - $funct3$             $:$ $3'b110$
   - $funct7$             $:$ $7'b000$ _ $0000$
   - $rs1$ _ $addr$       $:$ $5'h9$
   - $rs2$ _ $addr$       $:$ $5'ha$
   - $rd$ _ $addr$        $:$ $5'h3f$


### *Tool Simulation :*
<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/f6f3d137-81b6-467b-b730-4cedd313caab" width="800">
</p> 

### *J - Type :*
- $Instruction$ $:$ $jalr$ $x9$, $x10$, $0x1$

- $As$ $per$ $the$ $ISA$,
   - $Hex$ $equivalent$   $:$  $001504e7$
   - $Bin$ $equivalent$   $:$ $00000000000101010000010011100111$
   - $Opcode$             $:$ $110$ _ $0111$
   - $funct3$             $:$ $3'b000$
   - $funct7$             $:$ $7'b000$ _ $0000$
   - $rs1$ _ $addr$       $:$ $5'ha$
   - $rs2$ _ $addr$       $:$ $(ignorable)$
   - $rd$ _ $addr$        $:$ $5'h9$


### *Tool simulation :*

<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/b996d9ef-c334-4d76-b1b7-925bdb45720d" width="800">
</p> 

### *U - Type :*
- $Instruction$ $:$ $lui$  $x13$, $0x56789$

 - $As$ $per$ $the$ $ISA$,
   - $Hex$ $equivalent$   $:$  $567896b7 $
   - $Bin$ $equivalent$   $:$ $01010110011110001001011010110111$
   - $Opcode$             $:$ $011$ _ $0111$
   - $funct3$             $:$ $3'b000$
   - $funct7$             $:$ $7'b000$ _ $0000$
   - $rs1$ _ $addr$       $:$ $(ignorable)$
   - $rs2$ _ $addr$       $:$ $(ignorable)$
  

### *Tool Simulation :*
<p align="center">
  <img src="https://github.com/ShoaibMalikSM/README-2-.md/assets/156204834/f2cb52b4-21c7-4870-9388-1cbeb00fe1d5" width="800">
</p> 




