# About

Boolean logic is a branch of Boolean algebra, where boolean expressions are combined using logical operators, in Julia called [boolean operators](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Boolean-Operators), to form logical statements that evaluate to either `true` or `false`.

Below, we present tables that illustrate what results are produced when boolean operators are combined with given expressions.

## Logical _and_ (&&) table

|   A   |   B   | A && B |
| :---: | :---: | :----: |
| true  | true  |  true  |
| true  | false | false  |
| false | true  | false  |
| false | false | false  |

A and B in the above _table_ represent any expression for ex: `2 == 2 * 1`, `true` or `1 > 0`, anything that is unambiguously `true` or `false`. The last column `A && B` shows the result.

The only time the boolean operator `&&` produces a `true` result is when both A and B are `true`.

### Logical _and_ (&&) examples

```julia
julia> 3 / 3 == 1
true

julia> -0.0 == 0.0
true

julia> -1 == -(-1)
false

# An example when && returns true.
julia> 3 / 3 == 1 && -0.0 == 0.0
true

# An example when && returns false.
# Parentheses make it more readable,
# although not required here.
julia> (-0.0 == 0.0) && (-1 == -(-1))
false
```

## Logical _or_ (||) table

|   A   |   B   | A \|\| B |
| :---: | :---: | :------: |
| true  | true  |   true   |
| true  | false |   true   |
| false | true  |   true   |
| false | false |  false   |

The only time `A||B` results in `false` is when both A and B are `false`.

```exercism/note
We recommend referencing both tables to able to predict the resulting boolean logic before using Julia, to allow to internalize their behaviour.
```

### Logical _or_ (||) examples

```julia
julia> 1 * 0 == 1
false

julia> -0.0 == 0.0
true

julia> -1 == -(-1)
false

# An example when || returns true.
julia> -0.0 == 0.0 || 1 * 0 == 1
true

# An example when || returns false.
julia> (1 * 0 == 1) || (-1 == -(-1))
false
```

## Logical _not_ (!) table

|   A   |  !A   |
| :---: | :---: |
| true  | false |
| false | true  |

`!` negates any logical expression.

### Logical _not_ (!) examples

```julia
julia> 1 * 0 == 1
false

julia> true
true

# An example when ! returns true.
julia> !(1 * 0 == 1)
true

# An example when ! returns false.
julia> !true
false
```

## Chaining boolean operators

Julia allows for chaining of boolean operators to define the boolean logic of a logical statement.

```julia
# && is evaluated first,
# and then ||
julia> 1 * 0 == 0 || -1 == -(-1) && 3 / 3 == 1 && -0.0 == 0.0
true

# Changed 1 * 0 == 0 to 1 * 0 == 1
# in the below boolean expression.
julia> 1 * 0 == 1 || -1 == -(-1) && 3 / 3 == 1 && -0.0 == 0.0
false

# Negating the latter expression.
julia> !(1 * 0 == 1 || -1 == -(-1) && 3 / 3 == 1 && -0.0 == 0.0)
true

# Using all operators and parentheses.
julia> isinf(Inf) && !(isequal(-0.0, 0.0) && 1 == -1) || isfinite(Inf)
true
```

In Julia, according to the [operator precedence](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Operator-Precedence-and-Associativity), `&&` has higher prority over `||`.

Whenever negating an expression always wrap it in parentheses then apply `!`. For ex: `2 * 5 < 11` which is `true`, negating it will be `!(2 * 5 < 11)` which evaluates to `false`.

However, `!2 * 5 < 11` will return `ERROR: MethodError: no method matching`. Since negating an `Int64` makes no logical sense.
