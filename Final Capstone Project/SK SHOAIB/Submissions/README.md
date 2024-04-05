 
# Assignment on Representation Of Numbers

  By using Binary number system we can represent the both positive and negative decimal numbers.We can represent them by using the following ways.
 [1] Sign-bit magnitude method
 [2] The 1’s complement method 
 [3] The 2’s complement method


 Comparison:
 
 |**Sign-Bit Magnitude**|**1's complement**|**2's complement**|
 |---|---|---|
 |Sign-bit magnitude representation,represents both positive and negative decimal numbers| In the 1’s complement format, the positive numbers remain unchanged| The MSB represents the sign,‘0’ is used for representing a plus sign and a ‘1’ is used for representing a minus sign|
 |The MSB represents the sign, ‘0’ is used for representing a plus sign and a ‘1’  is used for representing a minus sign|The negative numbers are  obtained by taking the 1’s complement of the positive counterparts|Negative magnitudes are represented by the 2’s complement of their  positive counterparts|
|**Range**: −(2n−1−1) to +(2n−1−1)|**Range**: −(2n−1−1) to +(2n−1−1)|**Range**:  +(2n−1−1) to −(2n−1) |
|[1] 52 in Sig-Bit Representation:(0 110100)b|[1] 52 1's complement:(0001011)b|[1] 52 in 2's complement: (00110100)b|
|[2] -64 in Sig-Bit Representation:(1 1000000)b|[2]-64 1's complement:(0111111)b|[2] -64 in 2's complement: (1000000)b|
|[3] 31 in Sig-Bit Representation:(0 11111)b|[3] 31 1's complement:(11100000)b|[3] 31 2's complement:(11100001)b|
|[4] -129 in Sig-Bit Representation:(1 0000001)b|[4] -129 1's complement:(01111110)b|[4] -129 2's complement:(01111111)b
