# Introduction

Julia provides a number of [arithmetic operators](https://en.wikipedia.org/wiki/Arithmetic#Arithmetic_operations) for numeric types[^1].

[^1]: You can find a list of them in the [Julia Manual](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Arithmetic-Operators).

Below are examples of some arithmetic operations in Julia. You may find that Julia embraces unicode operators more than many other languages.

```julia
# Exponentiation
julia> 3 ^ 2
9
```

```julia
# Integer Division
# ÷ can be typed as \div<tab>
julia> 5 ÷ 2
2
```

In he latter operation after performing division is **truncated** to an integer.

```julia
# Modulo
julia> 7 % 2
1
```
