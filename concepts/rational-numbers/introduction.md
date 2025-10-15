# Introduction

[`Rational numbers`][rational] are fractions with an integer numerator divided by an integer denominator.

For example, we can store `2//3` as an exact fraction instead of the approximate `Float64` value `0.6666...`

The advantage is that (except in the extreme case of [integer overflow][integer-overflow]) a rational number will remain exact, avoiding the rounding errors that are often inevitable with floating-point numbers.

Some further details are in the Julia [manual page][julia-rational].

Rational numbers are quite a simple numeric type and aim to work much as you would expect.
Because they have been a standard type in Julia since the early versions, most functions will accept them as input in the same way as integers and floats.

## Creating rational numbers

Creation is as simple as using `//` between two integers.

```julia-repl
julia> 3//4
3//4

julia> a = 3; b = 4;

julia> a//b
3//4
```

Common factors are automatically removed, converting the fraction to its ["lowest terms"][lowest-terms]: the smallest integers that accurately represent the fraction, and with a non-negative denominator.

```julia-repl
julia> 5//15
1//3

julia> 5//-15
-1//3
```

Infinite results are accepted, though not [`NaN`][NaN].

```julia-repl
julia> 1//0
1//0

julia> float(1//0)
Inf

julia> 0//0
ERROR: ArgumentError: invalid rational: zero(Int64)//zero(Int64)
```

## Arithmetic with rational numbers

The usual [`arithmetic operators`][operators] `+ - * / ^ %` work with rationals, essentially the same as with other numeric types.

Integers and other `Rational`s can be included and give a `Rational` result.
Including a `float` in the expression results in `float` output, with a consequent (possible) loss in precision.

If a `float` is desired, simply use the `float()` function to convert a rational.
It is quite normal to use rational numbers to preserve precision through a long calculation, then convert to a float at the end.

```julia-repl
julia> 3//4 + 1//3  # addition
13//12

julia> 3//4 * 1//3  # multiplication
1//4

julia> 3//4 / 1//3  # division
9//4

julia> 3//4 ^ 2  # exponentiation
3//16

julia> 3//4 + 5  # rational and int => rational
23//4

julia> 3//4 + 5.3  # rational and float => float
6.05

julia> float(3//4)  # casting
0.75
```

Rationals and [complex numbers][complex] can also be combined.
Complex numbers are discussed in a [separate concept][complex-concept].

## Other operations

In Julia, rational numbers are just numbers.
The compiler will usually convert types as necessary.

However, beware that comparisons work for fractions with a finite decimal representation:

```julia-repl
julia> 3//4 == 0.75
true

julia> 3//4 < 0.74
false
```

But, otherwise, a `Rational` should be cast to a `Float` for comparisons:

```julia-repl
julia> 1//3 == 1/3
false

julia> float(1//3) == 1/3
true
```

Mathematical functions take rationals as input, but may give a floating-point result:

```julia-repl
julia> sqrt(9//16)
0.75
```

[rational]: https://en.wikipedia.org/wiki/Rational_number
[julia-rational]: https://docs.julialang.org/en/v1/manual/complex-and-rational-numbers/#Rational-Numbers
[lowest-terms]: https://en.wikipedia.org/wiki/Fraction#Simplifying_(reducing)_fractions
[NaN]: https://en.wikipedia.org/wiki/NaN
[complex]: https://en.wikipedia.org/wiki/Complex_number
[operators]: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Arithmetic-Operators
[0.30000000000000004]: https://0.30000000000000004.com/
[integer-overflow]: https://en.wikipedia.org/wiki/Integer_overflow
[complex-concept]: https://exercism.org/tracks/julia/concepts/complex-numbers
