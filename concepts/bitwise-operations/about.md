# About

Binary digits ultimately map directly to the transistors in your CPU or RAM, and whether each is "on" or "off".

Low-level manipulation, informally called "bit-twiddling", is particularly important in system languages.

High-level languages like Julia usually abstract away most of this detail.
However, a full range of bit-level operations are [available][bitwise] in the base language.

## Bit-shift operations

Integer types, signed or unsigned, can be represented as a string of 1's and 0's.

```julia-repl
julia> bitstring(UInt8(5))
"00000101"
```

Bit-shifts just move everything to the left or right by a specified number of positions.
With `UInt` types, some bits drop off one end, and the other end is padded with zeros:

```julia-repl
julia> ux::UInt8 = 5
5

julia> bitstring(ux)
"00000101"

julia> bitstring(ux << 2) # left by 2
"00010100"

julia> bitstring(ux >> 1) # right by 1
"00000010"
```

The `bitstring()` function is merely a convenient was to see the binary in human-readable form.

With signed integers, we need to be a bit more careful.

Left shifts are relatively simple:

```julia-repl
julia> sx = Int8(5)
5

julia> bitstring(sx) # positive integer
"00000101"

julia> bitstring(sx << 2)
"00010100"

julia> bitstring(-sx) # negative integer
"11111011"

julia> bitstring(-sx << 2)
"11101100"
```

Left-shifting positive signed integers is thus the same as with unsigned integers.

Negative values are stored in [two's complement][2complement] form, which means that the left-most bit is 1.
No problem for a left-shift, but when right-shifting how do we pad the left-most bits?

```julia-repl
julia> bitstring(sx >> 2) # simple for positive values!
"00000001"

julia> bitstring(-sx) # negative integer
"11111011"

julia> bitstring(-sx >> 2) # pad with repeated sign bit
"11111110"

julia> bitstring(-sx >>> 2) # pad with 0
"00111110"
```

The `>>` operator performs [arithmetic shift][arithmetic], preserving the sign bit.

The `>>>` operator performs [logical shift][logical], padding with zeros as if the number was unsigned.

If that still feels incomplete, there is also a [`bitrotate()`][bitrotate] function.

## Bitwise logic

We saw in a previous Concept that the operators `&&` (and), `||` (or) and `!` (not) are used with boolean values.

There are equivalent operators `&` (bitwise and), `|` (bitwise or) and `~` (a tilde, bitwise not) to compare the bits in two integers.

In the code below, ignore the `|> bitstring` entries (they "pipe" the result to a formatter, as explained in a future concept).

```julia-repl
julia> 0b1011 & 0b0010   |> bitstring # bit is 1 in both numbers
"00000010"

julia> 0b1011 | 0b0010   |> bitstring # bit is 1 in at least one number
"00001011"

julia> ~0b1011   |> bitstring # flip all bits
"11110100"

julia> xor(0b1011, 0b0010)  |> bitstring # bit is 1 in exactly one number, not both
"00001001"
```

Here, `xor()`  is [exclusive-or][xor], used as a function (see below for an alternative notation).

Incidentally, the `&` and `|` operators can also be used with booleans.
Unlike `&&` and `||`, all parts of the expression are then evaluated: there is no short-circuiting.


## Other symbols

Julia loves mathematics, and mathematicians love cryptic symbols, therefore we have more symbols to play with.

```julia-repl
julia> 0b1011 ⊻ 0b0010 |> bitstring # xor() in infix notation
"00001001"

julia> 0b1011 ⊼ 0b0010 |> bitstring # not and
"11111101"

julia> 0b1011 ⊽ 0b0010 |> bitstring # not or
"11110100"
```

These are entered as `\xor`, `\nand` and `\nor` plus a tab in each case.

These are not well-known, even among people who have taken college mathematics (the author of this Concept had never seen them before).
If you want to use them, be careful who you ask to review your code!


[bitwise]: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Bitwise-Operators
[xor]: https://en.wikipedia.org/wiki/Exclusive_or
[2complement]: https://en.wikipedia.org/wiki/Two%27s_complement
[arithmetic]: https://en.wikipedia.org/wiki/Arithmetic_shift
[logical]: https://en.wikipedia.org/wiki/Logical_shift
[bitrotate]: https://docs.julialang.org/en/v1/base/math/#Base.bitrotate
