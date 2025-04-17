# Introduction

## Booleans in Julia

True or false values are represented by the `Bool` type.
It contains only two values: `true` and `false`.

```julia-repl
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

In Julia (and many other programming languages), `&&` has a [higher precedence][operator-precedence] than `||` (in the same way that `*` is applied before `+`).
This means that `true || false && true` evaluates to `true` because it is parsed as `(true || false) && true`.
It is common to include explicit brackets anyway so that the reader doesn't need to think about this.

### Logical _not_

`!` represents the logical "not" operation in  Julia.
Not is also called negation.

```julia-repl
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

`&&` (two ampersands) represents logical "and" in Julia.

```julia-repl
julia> 5 > 3
true

julia> 1 != 0
true

julia> (5 > 3) && (1 != 0)
true
```

Parentheses are optional and can make the code easier to read.

### Logical _or_

`||` (two pipe characters) represents logical "or" in Julia.

```julia-repl
julia> 5 * 5 == 25
true

julia> 2 < 1
false

julia> (5 * 5 == 25) || (2 < 1)
true
```

[operator-precedence]: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Operator-Precedence-and-Associativity
