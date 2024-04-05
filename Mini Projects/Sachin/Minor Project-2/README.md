DESIGN SPECIFICATIONS

a) DESIGN:

Transmitter A   ===>   Receiver B

Transmitter A sends data with a Burst size of 120 to the Receiver B at a frequency of 200MHz


b) WRITE INTERFACE:

	wr_clk(200MHz)
	wr_en(active high for write output)
	wr_data(8-bit data from the transmitter)
	wr_rst(active high)
	
c) READ INTERFACE:

	rd_clk(200MHz)
	rd_en(active high)
	rd_data(8-bit data from receiver)
	rd_rst(active high)
	rd_ptr = 0(initial case)

d)FIFO STATUS INTERFACE:
	
	O_fifo_full(High if FIFO is full)
	O_fifo_empty(High if FIFO is empty)



ARCHITECTURE USED:
<p align = "center">
  <img src="https://github.com/Sachind01/G16/assets/114092614/896c25b7-d2bb-4d43-b582-2d6d1b33cfd4" width="720px" Height="auto">
</p>

SIMULATION RESULTS:

<p align = "center">
  <img src="https://github.com/Sachind01/G16/assets/114092614/08bee78a-fe44-4f40-8282-f057d3a68557" width="720px" Height="auto">
</p>

<p align = "center">
  <img src="https://github.com/Sachind01/G16/assets/114092614/fc594129-7144-4110-8bf8-08b76848948a" width="720px" Height="auto">
</p>

<p align = "center">
  <img src="https://github.com/Sachind01/G16/assets/114092614/1b232871-f3a9-42b2-bfe4-70ffe8b3ca7a" width="720px" Height="auto">
</p>