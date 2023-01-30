# Introduction

Imagine we have the following Boolean expressions in Julia: `5 > 3` and `1 != 0`, both of the expression are logically `true`. How can we combine the previously mentioned expressions to produce a `true` or `false` result?

We use [logical connectives](https://en.wikipedia.org/wiki/Logical_connective)! Also called _logical operators_. In Julia, they are called [Boolean operators](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Boolean-Operators).

Below, we provide examples on how to use them to produce the desired result.

## Logical _and_

```julia
julia> 5 > 3
true

julia> 1 != 0
true

# && (two ampersands juxtaposed) - represents logical and in Julia.
# Parentheses are optinal, however,
# it provides easier readability.
julia> (5 > 3) && (1 != 0)
true
```

## Logical _or_

```julia
julia> 5 * 5 == 25
true

# Checks for signed zeros.
julia> isequal(-0.0, 0.0) # -0.0 == 0.0 - returns true.
false

# || (two pipe characters juxtaposed),
# represents logical or in Julia.
julia> (5 * 5 == 25) || isequal(-0.0, 0.0)
true
```

## Logical _not_

```julia
julia> NaN == NaN
false

# ! - represents logical not in  Julia.
# Also called negation.
# Parentheses required.
julia> !(NaN == NaN)
true

julia> !false
true
```

In Julia, according to the [operator precedence](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Operator-Precedence-and-Associativity), `&&` has higher prority over `||`.
