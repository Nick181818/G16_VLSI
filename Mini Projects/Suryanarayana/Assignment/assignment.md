|               | Signed Magnitude  | 1's complement | 2's complement|
|---------------|:-----------------:|:-------------: |---------------:|
|Range for 8 bit| -127 to +127      |-127 to +127    |-128 to +127    |
|    +52        | 00110100          | 11001011       | 11001100       |
|    -64        | 11100000          | 00011111       | 00100000       |
|    +31        | 00011111          | 11100000       | 11100001       |
|    -129       | 1111111111000001  |0000000000111110|0000000000111111|
-> sign magnitude
The leftmost bit represents the sign of the number
-0 for positive
-1 for negative
-> 1's complement
- 1's becomes 0's , 0's becomes 1's
-> 2's complement
- To represent negative number, the corresponding positive number is inverted and 1 is added to the result