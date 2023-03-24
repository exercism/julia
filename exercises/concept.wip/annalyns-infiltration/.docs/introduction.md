# Introduction

## Booleans in Julia

True or false values are represented by the `Bool` type.
It contains only two values: `true` and `false`.

```julia
julia> true
true

julia> false
false

julia> typeof(true)
Bool
```

## Boolean logic

Imagine we have the following Boolean expressions in Julia: `5 > 3` and `1 != 0`, both of the expression are logically `true`. How can we combine the previously mentioned expressions to produce a `true` or `false` result?

We use [Boolean operators](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Boolean-Operators): `!` (not), `&&` (and), `||` (or).

Below, we provide examples on how to use them to produce the desired result.

### Logical _not_

```julia
# ! - represents logical not in  Julia.
# Also called negation.

julia> !false
true

julia> false != true
true

# Parentheses may be required.
julia> !(false == true)
true
```

### Logical _and_

```julia
julia> 5 > 3
true

julia> 1 != 0
true

# && (two ampersands juxtaposed) - represents logical and in Julia.
# Parentheses are optional, but they provide easier readability.
julia> (5 > 3) && (1 != 0)
true
```

### Logical _or_

```julia
julia> 5 * 5 == 25
true

julia> 2 < 1
false

# || (two pipe characters juxtaposed),
# represents logical or in Julia.
julia> (5 * 5 == 25) || (2 < 1)
true
```

In Julia, according to the [operator precedence](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Operator-Precedence-and-Associativity), `&&` has higher prority than `||`.
