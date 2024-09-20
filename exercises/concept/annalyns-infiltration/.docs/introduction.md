# Introduction

## Booleans in Julia

True or false values are represented by the `Bool` type.
It contains only two values: `true` and `false`.

```julia-repl
julia> true
true

julia> false
false
```

## Boolean Operators

There are three Boolean operators in Julia.

`&&` is Boolean "and".
It evaluates to `true` if the expressions on *both* sides of `&&` are `true`.

```julia-repl
julia> true && true
true

julia> true && false
false
```

`||` is Boolean "or".
It evaluates to `true` if an expression on *either* side of `||` is `true`.

```julia-repl
julia> true || true
true

julia> false || true
true
```

`!` is Boolean "not".
It exchanges `true` and `false` values.

```julia-repl
julia> !true
false

julia> !false
true
```

For longer and more complicated expressions, it is best to use parentheses to make your intention clear.

```julia-repl
julia> (true || false) && (false && true)
false
```