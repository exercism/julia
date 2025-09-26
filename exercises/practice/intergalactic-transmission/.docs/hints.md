# Hints

## General

- All parts of this exercise rely on bitwise operations.
  - Exercism's [Learning Syllabus][concept-bitwise-operations] provides a gentle introduction.
  - [Bitwise operators][ref-bitwise-operators] are listed in the Julia manual.
  - `Base` contains various useful bit-related functions, including [count_ones()][count_ones] and [trailing_zeros()][trailing_zeros].
- The tests try not to be prescriptive about types, but the exercise is about unsigned bytes and [`UInt8`][uint8] values are relatively easy to reason about.
  - Arguments and return values are `Vector{UInt8}`,
  - `UInt8` values are helpful for bit-masks and intermediate values.
- Decimal numbers would be a distraction, so prefer hex (`0xFF`) or binary (`0b11111111`) for `UInt8` literals.
  - The [`bitstring()`][bitstring] function can be useful in debugging, as it outputs a human-readable binary format.
- A raw message comes in a vector of 8-bit chunks, and needs to be converted to 7-bit chunks in the higher-order bits plus a parity bit as the LSB.
  - Use bit-masks with `&` or `|` to isolate the bits you want.
  - Left-shift (`<<`) and logical right-shift (`>>>`) operators are important.
  - Plan a way to carry excess bits to the next round of processing.
  - The carry makes it hard to handle input bytes independently of one another, so looping (or perhaps recursion) is probably easier than trying to use higher-order functions.
  - Encoded messages are typically longer (more bytes) than the raw message, to accommodate a parity bit per byte.


  [concept-bitwise-operations]: https://exercism.org/tracks/julia/concepts/bitwise-operations
  [ref-bitwise-operators]: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Bitwise-Operators
  [count_ones]: https://docs.julialang.org/en/v1/base/numbers/#Base.count_ones
  [trailing_zeros]: https://docs.julialang.org/en/v1/base/numbers/#Base.trailing_zeros
  [uint8]: https://docs.julialang.org/en/v1/base/numbers/#Core.UInt8
  [bitstring]: https://docs.julialang.org/en/v1/base/numbers/#Base.bitstring
