# Binary Representation of Signed Numbers

This table shows the binary representation of signed numbers using different representations: signed representation, 1's complement, and 2's complement.

## Definitions

- **Signed Representation**: The signed representation of a number uses a sign bit to indicate whether the number is positive or negative.
- **1's Complement**: In 1's complement representation, negative numbers are obtained by flipping all the bits of the positive number.
- **2's Complement**: In 2's complement representation, negative numbers are obtained by taking the 1's complement of the positive number and adding 1 to the result.

## Range of n bits

For an n-bit signed representation:
- The range is from -2^(n-1) to (2^(n-1)) - 1.
- For example, for an 8-bit signed representation, the range is from -128 to 127.

For an n-bit 1's Complement representation:
- The range is from -2^(n-1) to (2^(n-1)) - 1.
- For example, for an 8-bit 1's Complement representation, the range is from -127 to 127.

For an n-bit 2's Complement representation:
- The range is from -2^(n-1) to (2^(n-1)) - 1.
- For example, for an 8-bit 2's Complement representation, the range is from -128 to 127.

## Binary Representation

|      | Signed Representation  | 1's Complement     | 2's Complement    |
|------|------------------------|--------------------|-------------------|
| +52  | 00000000 00110100      | 00000000 00110100  | 00000000 00110100 |
| -61  | 10000000 00111101      | 11111111 11000010  | 11111111 11000011 |
| +31  | 00000000 00011111      | 00000000 00011111  | 00000000 00011111 |
| -129 | 10000000 10000001      | 11111111 01111110  | 11111111 01111111 |
