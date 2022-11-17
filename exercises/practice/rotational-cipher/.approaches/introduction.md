# Introduction

## General guidance

- The key lesson from this exercise is that you can define two methods for the function `rotate`
- The macro/metaprogramming is quite challenging for lots of students. Feel free to read the answer below!

## Approach: modulo arithmetic

```julia
"""
    rotate(n, c::AbstractChar)

Rotate `c` `n` places if it is an ASCII letter, else return it

"""
function rotate(n, c::AbstractChar)
    if c in 'a':'z'
        'a' + (c - 'a' + n) % 26
    elseif c in 'A':'Z'
        'A' + (c - 'A' + n) % 26
    else
        c
    end
end

"""
    rotate(n, itr)

Rotate each ASCII alphabetic character in iterable `n` places

"""
rotate(n, itr) = map(c -> rotate(n, c), itr)
```

Breakdown of `'a' + (c - 'a' + n) % 26`:

This works because:

1. subtracting one character from another gives the distance between them as an `Int` (e.g. `'d' - 'a' == 3`)
1. adding an `Integer` to a `Char` returns a `Char` shifted by the integer (e.g. `'a' + 3 == 'd'`)

```
(c - 'a' + n)
└──┬───┘
   └─ returns the "distance" between both characters in the
      alphabet as an Int (e.g. `'b' - 'a' == 1`).
```

```
'a' + (c - 'a' + n) % 26
└┬┘   └────────┬───────┘
 │             └─ returns an Int that specifies how much the
 │                character needs to be shifted compared to
 │                the beginning of the alphabet ('a').
 └─ The beginning/base of the alphabet.
```

```exercism/advanced

Iterating a UTF-8 string is slow because it's a variable length encoding. It is often faster to iterate a collection with elements of a fixed size (a vector of `UInt8`s from `transcode()` or an `ASCIIStr` (from Strs.jl), perhaps).

See the dig deeper pages for the [pangram][dd-pg], [nucleotide count][dd-nc], and [luhn][dd-l] exercises for more details on how to safely and efficiently use `transcode` (if you can't see a pages when you follow the link, try completing the exercise first).

```

## Bonus macro task

Just R13:

```julia
macro R13_str(s)
    rotate(13, s)
end
```

All of the macros done with a for loop:

```julia
for n in 0:26
    @eval macro $(Symbol(:R, n, :_str))(s)
        rotate($n, s)
    end
end
```

[dd-pg]: https://exercism.org/tracks/julia/exercises/pangram/dig_deeper
[dd-nc]: https://exercism.org/tracks/julia/exercises/nucleotide-count/dig_deeper
[dd-l]: https://exercism.org/tracks/julia/exercises/luhn/dig_deeper
