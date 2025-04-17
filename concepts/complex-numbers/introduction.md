# Introduction

`Complex numbers` are not complicated.
They just need a less alarming name.

They are so useful, especially in engineering and science, that Julia includes complex numbers as standard numeric types alongside integers and floating-point numbers.

## Basics

A `complex` value in Julia is essentially a pair of numbers: usually but not always floating-point.
These are called the "real" and "imaginary" parts, for unfortunate historical reasons.
Again, it is best to focus on the underlying simplicity and not the strange names.

To create complex numbers from two real numbers, just add the suffix `im` to the imaginary part.

```julia-repl
julia> z = 1.2 + 3.4im
1.2 + 3.4im

julia> typeof(z)
ComplexF64 (alias for Complex{Float64})

julia> zi = 1 + 2im
1 + 2im

julia> typeof(zi)
Complex{Int64}
```

Thus there are various `Complex` types, derived from the corresponding integer or floating-point type.

To create a complex number from real variables, the above syntax will not work.
Writing `a + bim` confuses the parser into thinking `bim` is a (non-existent) variable name.

Writing `b*im` is possible, but the preferred method uses the `complex()` function, which sidesteps the multiplication and addition operations.

```julia-repl
julia> a = 1.2; b = 3.4; complex(a, b)
1.2 + 3.4im
```

To access the parts of a complex number individually:

```julia-repl
julia> z = 1.2 + 3.4im
1.2 + 3.4im

julia> real(z)
1.2

julia> imag(z)
3.4
```

Or together:

```julia-repl
julia> reim(z)
(1.2, 3.4)
```

Either part can be zero and mathematicians may then talk of the number being "wholly real" or "wholly imaginary".
However, it is still a complex number in Julia.

```julia-repl
julia> zr = 1.2 + 0im
1.2 + 0.0im

julia> typeof(zr)
ComplexF64 (alias for Complex{Float64})

julia> zi = 3.4im
0.0 + 3.4im

julia> typeof(zi)
ComplexF64 (alias for Complex{Float64})
```

You may have heard that "`i` (or `j`) is the square root of -1".

For now, all this means is that the imaginary part _by definition_ satisfies the following equality:

```julia-repl
julia> 1im * 1im == -1
true
```

This is a simple idea, but it leads to interesting consequences.

## Arithmetic

All of the standard mathematical `operators`] and elementary functions used with floats and integers also work with complex numbers. A small sample:

```julia-repl
julia> z1 = 1.5 + 2im
1.5 + 2.0im

julia> z2 = 2 + 1.5im
2.0 + 1.5im

julia> z1 + z2  # addition
3.5 + 3.5im

julia> z1 * z2  # multiplication
0.0 + 6.25im

julia> z1 / z2  # division
0.96 + 0.28im

julia> z1^2  # exponentiation
-1.75 + 6.0im

julia> 2^z1  # another exponentiation
0.5188946835878313 + 2.7804223253571183im
```

## Functions

There are several functions, in addition to `real()` and `imag()`, with particular relevance for complex numbers.

- `conj()` simply flips the sign of the imaginary part of a complex number (_from + to - or vice-versa_).
    - Because of the way complex multiplication works, this is more useful than you might think.
- `abs(<complex number>)` is guaranteed to return a real number with no imaginary part.
- `abs2(<complex number>)` returns the square of `abs(<complex number>)`: quicker to calculate than `abs()`, and often what a calculation needs.
- `angle(<complex number>)` returns the phase angle in radians.

```julia-repl
julia> z1
1.5 + 2.0im

julia> conj(z1)
1.5 - 2.0im

julia> abs(z1)
2.5

julia> abs2(z1)
6.25

julia> angle(z1)
0.9272952180016122
```
A partial explanation, for the mathematically-minded:

- The `(real, imag)` representation of `z1` in effect uses Cartesian coordinates on the complex plane.
- The same complex number can be represented in `(r, θ)` notation, using polar coordinates.
- Here, `r` and `θ` are given by `abs(z1)` and `angle(z1)` respectively.

Here is an example using some constants:

```julia-repl
julia> euler = exp(1im * π)
-1.0 + 1.2246467991473532e-16im

julia> real(euler)
-1.0

julia> round(imag(euler), digits=15)  # round to 15 decimal places
0.0
```

The polar `(r, θ)` notation is so useful, that there are built-in functions `cis` and `cispi` for constructing it more efficiently.

```julia-repl
julia> exp(1im * π) ≈ cis(π) ≈ cispi(1)
true
```

The approximate equality above is because the functions `cis` and `cispi` can give nicer numerical outputs, with `cispi` in particular when dealing with arguments that are arbitrary factors of π (e.g. radians!).

```julia-repl
julia> cis(π)
-1.0 + 0.0im

julia> cispi(1)
-1.0 + 0.0im

julia> θ = π/2;
julia> exp(im*θ)
6.123233995736766e-17 + 1.0im

julia> cis(θ)
6.123233995736766e-17 + 1.0im

julia> cispi(θ / π)  # θ/π == 1/2
0.0 + 1.0im
```
