# About

In Julia, `true` and `false` are the logical values of the `Bool` type, and can represent a trivial [boolean expression](https://en.wikipedia.org/wiki/Boolean_expression). Since `true` is a logical statement that unambiguously evaluates to `true`. Similarly can be said for `false`.

## Expressions involving [numeric comparisons](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Numeric-Comparisons)

```julia
# true is numerically equal to 1
julia> true ≥ 1
true

# √ can be typed as \sqrt<tab>
# Equivalently √100 can be written as sqrt(100)
julia> 120 % 11 == √100
true

# false is numerically equal to 0
julia> false * 10^3 != 0
false

# Julia permits chaining of numeric comparisons.
# x = 5
julia> 1 ≤ x ≤ 9
true
```

## Expression involving [boolean operators](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Boolean-Operators)

```julia
# && read and, is a binary operator.
julia> 6 == 3 * 2 && 5 ≥ 0
true

## || read or, is a binary operator.
julia> 5 % 2 == 0 || -1 ≥ 0
false

# ! read negate, is a unary operator.
julia> !(1234 ÷ 5 + true == 246)
true
```

The order of operations in a boolean expression is evaluated based on [operator precedence](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Operator-Precedence-and-Associativity).

## Expression involving built-in Bool functions

```julia
# == considers NaN as not equal to itself.
julia> NaN == NaN
false

# isequal(x, y) tests if x and y are equal.
# isequal consider NaN equal to itself.
julia> isequal(NaN, NaN)
true

julia> -0.0 == 0.0
true

# isequal can be used to test for signed zeros.
julia> isequal(-0.0, 0.0)
false

# isfinite tests if a number is finite.
julia> isfinite(1 / Inf)
true

# isinf tests if a number is infinite.
# Overflow behavior - since the largest representable number
# in Julia for Int64 is 2^63 - 1.
# Therefore 2^64 wraps around to 0.0, and
# 1 / 0.0 returns Inf.
julia> isinf(1 / 2^64)
true
```

In latter code, we see Julia's [overflow behavior](https://docs.julialang.org/en/v1/manual/integers-and-floating-point-numbers/#Overflow-behavior) more can be read in this Julia [tutorial](https://www.matecdev.com/posts/julia-types-numerical.html#gotcha-integer-vs-float) by Martin D. Maas.
