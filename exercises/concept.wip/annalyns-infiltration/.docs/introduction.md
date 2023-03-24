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

Imagine we have the following Boolean expressions in Julia: `5 > x` and `x != 0`.
If `x` was 3 they would both be `true`.
We can express statements like "is x less than 5 and not equal to y?" using [Boolean operators](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Boolean-Operators): `!` (not), `&&` (and), `||` (or).

### Logical _not_

```julia
# ! - represents logical not in  Julia.
# Also called negation.

julia> !false
true

julia> false != true
true

julia> 3 != "apple"
true

julia> !(false == true)
true

julia> !(1 < 7)
false
```

### Logical _and_

```julia
julia> 5 > 3
true

julia> 1 != 0
true

# && (two ampersands) - represents logical "and" in Julia.
# Parentheses are optional and can make the code easier to read
julia> (5 > 3) && (1 != 0)
true
```

### Logical _or_

```julia
julia> 5 * 5 == 25
true

julia> 2 < 1
false

# || (two pipe characters),
# represents logical "or" in Julia.
julia> (5 * 5 == 25) || (2 < 1)
true
```

In Julia, according to the [operator precedence](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Operator-Precedence-and-Associativity), `&&` has higher prority than `||`.
