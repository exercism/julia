# About

Julia is a general-purpose language, that can be used for most programming tasks.
In practice, however, the main use cases tend to be in engineering and science.
Fast, versatile, sophisticated numerical calculations are central to the design.

## Integers

An [integer][integer] is a "round" number with no decimal point.

In the [Basics][basics] concept, we saw that an integer value can be assigned to a variable without specifying a type.

For readability, underscores can be used as a digit separator.
They are ignored by the compiler.

```julia-repl
julia> x = 3
3

julia> typeof(x)
Int64

julia> large_number = 1_234_567_890
1234567890
```

Internally, the compiler will use whatever signed integer type is most appropriate for your CPU.
On modern PCs this will usually be `Int64`, which is perfectly adequate for most tasks.

[Types][types] will be discussed more fully in a future concept.
For now, the [_numeric_ types][numeric-types] should hopefully be intuitive enough for this document to make sense.

As we will see in a later concept, Julia natively supports very large, multidimensional arrays.
These can challenge both the amount of available memory, and the bandwidth for data transfers.

To give finer control to the programmer, it is both possible and quite common to specify the desired signed or unsigned integer type.
The many Julia learners who have previously used Python may want to compare this to [NumPy][numpy], rather than base Python.

```julia-repl
julia> y = Int8(42)
42

julia> typeof(y)
Int8

julia> z = UInt32(1024)
0x00000400
```

Note that Julia defaults to displaying unsigned integers in [hexadecimal][hex] format, because the unsigned types are often used for low-level bit operations.

Integers can also be entered as binary, octal or hexadecimal, with prefixes `0b`, `0o` and `0x` respectively.

```julia-repl
julia> a = 0x10
0x10

julia> Int(a)
16

julia> b = 0b1010 # displays as hexadecimal
0x0a
```

## Integer overflows and `BigInt`

Each integer type has a maximum and minimum value that it can store:

```julia-repl
julia> typemax(Int8)
127

julia> typemin(Int8)
-128
```

Going outside this valid range will cause [*integer overflow*][integer-overflow], with results that appear very strange.

```julia-repl
julia> c = Int8(126)
126

julia> c * c
4
```

Probably we can agree that `126 * 126` should _not_ equal 4!

A detailed explanation needs a knowledge of how CPU registers store integers, which is outside the scope of this concept.

The problem can be minimized by using a "wider" type, up to Int128 or UInt128 (the meaning of "wider" is discussed below).
However, all have hard limits before running into overflow problems.

One solution is to use the [`BigInt`][bigint] type, which is limited only by the memory in your computer.
It is Julia's implementation of [arbitrary-precision arithmetic][arbitrary-precision].

```julia-repl
julia> 2 ^ 70
0

julia> big = BigInt(2) ^ 70
1180591620717411303424

julia> UInt128(big)
0x00000000000000400000000000000000
```

Because 2 to the power 70 will not fit into an `Int64`, the first calculation in the above example fails: although note that _there is no error message_.
Programmer beware!

[Casting][casting] 2 to a `BigInt` gives the correct answer, and displaying it in hexadecimal makes clearer that this is a power of 2.

## Floating-point

It will be no surprise that [floating-point][float] numbers optionally have a decimal point, and a fractional part after the point.

```julia-repl
julia> f = 3.45
3.45

julia> typeof(f)
Float64
```

Of course, [scientific notation][scientific-notation] is supported.

```julia-repl
julia> avogadro = 6.02e23
6.02e23
```

As with integers, the default type is fine for most purposes, but other signed types are available.
There are no [_unsigned_ floating-point][unsigned-fp] types.

As a shortcut, `Float32` values can be created by using a `f0` suffix.

```julia-repl
julia> f32 = 4.56f0
4.56f0

julia> typeof(f32)
Float32
```

Other sizes of float need an explicit [cast][casting], as with integers.

The maximum and minimum values may come as a surprise:

```julia-repl
julia> typemax(Float64)
Inf

julia> typemin(Float64)
-Inf
```

[Infinity][infinity] is a valid value!

However, the useful range of floating-point numbers is limited, with anything very large just assigned an `Inf` value, and anything very small rounded to `0.0`.

We can use a different pair of functions to see these limits: roughly `± 10 ^ 308`.

```julia-repl
julia> floatmax(Float64)
1.7976931348623157e308

julia> floatmin(Float64)
2.2250738585072014e-308
```

Also, the precision is limited, with a large but finite number of [significant digits][sig-fig] represented (approximately 15 for `Float64`).

## Arithmetic operators

As discussed in the Basics concept, [arithmetic operators][operators] mostly work the same as standard arithmetic, as taught to children.
Note that [exponentiation][exponentiation] uses `^`, _not_ `**` (both are common in other languages).

```julia
2 + 3  # 5 (addition)
2 - 3  # -1 (subtraction)
2 * 3  # 6 (multiplication)
8 / 2  # 4.0 (division)
8 % 3  # 2 (remainder)
2 ^ 3  # 8 (exponentiation)
```

However, a few Julia-specific details are worth discussing.

### Multiplication

```julia-repl
julia> x = 4.2
4.2

julia> 2 * x
8.4

julia> 2x
8.4

julia> 2.4x
10.08
```

That may be surprising.

It is always possible to use `*` as an [infix][infix] operator, as in most other computer languages.

However, Julia is designed by people who believe that code should look as much as possible like mathematical equations.

Because variable names must start with a letter, prefacing the name with a number (integer or floating-point) is treated as implicit multiplication.

For example, if we want the surface area of a sphere, instead of `4 * pi * r * r` we could do this :

```julia-repl
julia> surface(r) = 4π * r^2
surface (generic function with 1 method)

julia> surface(3)
113.09733552923255
```

Although π is a built-in constant, it is also a (Greek) letter.
The parser therefore still needs one explicit `*` to separate `π` from `r`.

### Division

Using `/` as the [infix][infix] operator will always give a floating-point result, even for integer inputs.

For integer division, there are more options:

```julia-repl
julia> 10 / 3
3.3333333333333335

julia> div(10, 3)
3

julia> 10 ÷ 3
3

julia> 10 // 3
10//3
```

The `div()` function is for integer division, with the result truncated towards zero: downwards for positive numbers, upwards for negative numbers.

As a synonym, we can use the infix operator `÷`, again aiming to make it look more mathematical.
If you are using a Julia-aware editor, enter this as `\div` then hit the `<Tab>` key.

The `//` operator will need a concept of its own, later in the syllabus.

For now, we can just say that the result of `//` is a ["rational" number][rational], the formal name for what most people call a [fraction][fraction].

Common factors will be removed from the [numerator][fraction] and [denominator][fraction], to give a ratio of two integers in what is called the ["lowest terms"][lowest-terms].

```julia-repl
julia> rationalnum = 22 // 6
11//3

julia> typeof(rationalnum)
Rational{Int64}
```

We have rational numbers.
What about "irrational" numbers?

```julia-repl
julia> π
π = 3.1415926535897...

julia> typeof(π)
Irrational{:π}
```

An [irrational number][irrational] is one that cannot be reduced to a ratio of integers.
Common examples include `π`, `e` ([Euler's number][e]), and many [roots][root] such as `√2` (the square root of 2).

Julia tries to do mathematics _properly_.

## Conversion of numeric types

This can often happen automatically:

```julia-repl
julia> x = 2 + 3.5
5.5

julia> typeof(x)
Float64
```

We added an `Int64` to a `Float64`, and got a `Float64` result.

In fact, the integer was silently converted to a `Float64` before doing the addition.

Julia has a concept of the ["width"][width] of numeric types.

- Within integers, and within floats, this is just the number of bits needed for storage.
  Thus, `Int64` is wider than `Int16`.
- Floats are considered wider than integers, because floats can store any fractional part.

If a mixture of types is used within an expression, each is "promoted" as necessary to the widest type used.

To force the conversion, we can cast an integer to a specific type, as in `Float64(5)`.

Alternatively, just use `float(5)` and let the compiler choose an appropriate type.

**Float-to-integer** conversions are inevitably more complicated.
What do you want to do with anything after the decimal point?

- The `round()` function converts to the nearest whole number, with ties such as 4.5 rounding to the nearest _even_ whole number.
- `floor()` rounds down, `ceil()` rounds up, `trunc()` rounds towards zero.
- Attempting to cast directly, for example with `Int32()`, will fail with an [`InexactError`][inexact].

However, by default these functions do not return the integer type you might have wanted.
The desired output type can be specified.

```julia-repl
julia> round(4.5)
4.0

julia> round(Int64, 4.5)
4

julia> round(Int, 4.5)  # => default integer type
4

julia> ceil(Int16, 4.3)
5
```

Rounding to a specified number of digits after the decimal point is also possible with the `digits` keyword.

```julia-repl
julia> round(π, digits=10)
3.1415926536
```

See the [manual][round] for more details.

## Divide-by-zero

Surely this just throws an error?
In fact, the situation is not that simple.

Integer division with `÷` or `//` will result in an error, as you might expect.

Floating-point division with `/` takes what might be considered an engineering approach, rather than a standard computer science approach:

```julia-repl
julia> 2 / 0
Inf

julia> 0 / 0
NaN
```

As discussed in a previous section, [infinity][infinity] is a valid floating-point number in Julia, represented by `Inf`.

When the numerator is also zero, the result is mathematically undefined.
Julia then treats it as ["not a number"][NaN], represented by `NaN`.

If this seems strange, think of it in the context of working on large arrays of real-world (and thus often quite messy) data.
To make progress, it is best just to flag problematic values and move on.

Endless manual checking of values would be tedious to program, and would certainly hurt runtime performance.

Stopping with an error message at every slight glitch would make your program _very_ unpopular with users!

## Comparing floating-point values

As described in the [`Conditionals`][conditionals] concept, equality testing is usually done with the `==` operator.

This works well for integers, characters, strings, etc.
However, floating-point values have limited precision, and different ways of calculating the same result can lead to slightly different values.
For `Float64`, this will typically be around the 15th significant digit: a small difference, but not "equality".

Traditionally, the advice to programmers is _never_ use `==` with floating-point values: the results are unpredictable.

A widely-used alternative is to test the absolute value of the difference against some allowed tolerance (often called epsilon or ϵ).
So instead of `a == b`, use `abs(a - b) < epsilon`.

Julia provides a cleaner alternative with the [`isapprox()`][isapprox] function.

For an absolute tolerance, the syntax is `isapprox(a, b, atol=epsilon`).
The `atol` keyword is required in this case.

The relative tolerance is often more useful.
This is the default, so `isapprox(a, b)` will try to choose some sensible value for `rtol` (the rules are quite complicated).

A relative tolerance can also be specified, as a fraction of the values being compared.
So `isapprox(a, b, rtol=0.01` tests that the values are within 1% of each other.

In the usual Julia fashion, there is a mathematical operator that is a synonym for the default case: `a ≈ b` (with the operator entered as `\approx` then `<tab>`).

## Related future concepts

As well as rational numbers, later parts of the syllabus will discuss:

- [Complex numbers][complex], such as `2.3 + 4.5im`.
- [Bitwise][bitwise] operations, for low-level programming.


[basics]: https://exercism.org/tracks/julia/concepts/basics
[integer]: https://en.wikipedia.org/wiki/Integer
[numeric-types]: https://docs.julialang.org/en/v1/manual/integers-and-floating-point-numbers/
[float]: https://docs.julialang.org/en/v1/manual/integers-and-floating-point-numbers/#Floating-Point-Numbers
[types]: https://docs.julialang.org/en/v1/manual/types/
[rational]: https://en.wikipedia.org/wiki/Rational_number
[irrational]: https://en.wikipedia.org/wiki/Irrational_number
[integer-overflow]: https://en.wikipedia.org/wiki/Integer_overflow
[infinity]: https://en.wikipedia.org/wiki/Infinity
[NaN]: https://en.wikipedia.org/wiki/NaN
[numpy]: https://numpy.org/
[hex]: https://en.wikipedia.org/wiki/Hexadecimal
[arbitrary-precision]: https://en.wikipedia.org/wiki/Arbitrary-precision_arithmetic
[casting]: https://en.wikipedia.org/wiki/Type_conversion
[scientific-notation]: https://en.wikipedia.org/wiki/Scientific_notation
[unsigned-fp]: https://discourse.julialang.org/t/why-is-there-no-concept-of-unsigned-floats/14058
[sig-fig]: https://en.wikipedia.org/wiki/Significant_figures
[exponentiation]: https://en.wikipedia.org/wiki/Exponentiation
[infix]: https://en.wikipedia.org/wiki/Infix_notation
[fraction]: https://en.wikipedia.org/wiki/Fraction
[lowest-terms]: https://en.wikipedia.org/wiki/Fraction#Simplifying_(reducing)_fractions
[e]: https://en.wikipedia.org/wiki/E_(mathematical_constant)
[root]: https://en.wikipedia.org/wiki/Nth_root
[width]: https://en.wikipedia.org/wiki/Integer_(computer_science)#Value_and_representation
[round]: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Rounding-functions
[inexact]: https://docs.julialang.org/en/v1/base/base/#Core.InexactError
[complex]: https://en.wikipedia.org/wiki/Complex_number
[bitwise]: https://en.wikipedia.org/wiki/Bitwise_operation
[bigint]: https://docs.julialang.org/en/v1/base/numbers/#BigFloats-and-BigInts
[conditionals]: https://exercism.org/tracks/julia/concepts/conditionals
[isapprox]: https://docs.julialang.org/en/v1/base/math/#Base.isapprox
[operators]: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Arithmetic-Operators
[implicit-multiplication]: https://docs.julialang.org/en/v1/manual/integers-and-floating-point-numbers/#man-numeric-literal-coefficients
