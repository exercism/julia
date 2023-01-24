# Introduction

Julia provides a number of [arithmetic operators](https://en.wikipedia.org/wiki/Arithmetic#Arithmetic_operations) for numeric types[^1].

[^1]: You can find a list of them in the [Julia Manual](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Arithmetic-Operators).

Many of the arithmetic operations are straightforward. Below are examples of some operations in Julia that may have different **syntax** in other languages, ex: Python.

```julia
# Exponentiation
julia> 3 ^ 2
9
```

```julia
# Integer Division
julia> div(5, 2)
2
```

The latter operation after performing division is **truncated** to an integer.

```julia
# Modulo
# 7 % 2 syntax is also supported
julia> rem(7, 2)
1
```
