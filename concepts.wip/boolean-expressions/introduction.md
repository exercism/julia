# Introduction

A [boolean expression](https://en.wikipedia.org/wiki/Boolean_expression) is a logical statement[^1] that unambiguously evaluates to either `true` or `false`.

[^1]: A logical statement in Julia can combine variables/numeric types, [boolean operators](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Boolean-Operators) and [numeric comparisons](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Numeric-Comparisons).

We illustrate some examples of boolean expressions.

```julia
# A simple boolean expression.
julia> true
true

# Another trivial boolean expression.
julia> false
false

# Negation.
# A trivial logical statement.
julia> !false
true

# Less than or equal to numeric comparison.
# ≤ can be typed as \leq<tab>
julia> 5 ≤ 3
false

# greater than or equal to numeric comparison.
# ≥ can be typed as \geq<tab>
julia> 9 ≥ 9
true

# Julia allows for chaining numeric comparisons in an intuitive way.
# a = 3
# b = 6
julia> a ≥ 2 !=5 ≤ b == b > 5
true
```
