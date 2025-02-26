# About

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

In contrast to several other languages, Julia deliberately has no concept of "truthiness", and only expressions which evaluate to `true` or `false` will be treated as a `Bool`.

Specifically, empty arrays or strings will *not* be interpreted as `false`.
There must be an appropriate test such as `isempty()` if you want special handling for empty values.

## Boolean operators

There are three [Boolean operators][boolean-operators] in Julia.

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
It exchanges (inverts) `true` and `false` values.

```julia-repl
julia> !true
false

julia> !false
true
```

Similar operators will be conceptually familiar to users of many other languages, though the precise syntax may vary between languages.

## Operator precedence

In more complex expressions, it can be useful to know that `&&` has a slightly higher [precedence][operator-precedence] than `||` *(in the same way that `*` is applied before `+` in arithmetic expressions)*.

Relying on this can be confusing and error-prone.
For clarity, use parentheses to make your intention clear.

## Short-circuit evaluation

Does the expression `true || x` depend on the value of `x`, or can the compiler ignore `x`?

Julia evaluates Boolean expressions from left to right, and stops when it has an unambiguous result.

For example, `true || x` must be `true`, regardless of `x`, so `x` is not evaluated.
Similarly, `false && y` is `false`, with no need to evaluate `y`.

Conversely, `true && x` is `true` *only if* `x` is `true`, so `x` must be evaluated.

Similarly, if we chain multiple operators:

```julia-repl
julia> true && false && something_else
false
```

Because `true && false` must be `false`, the `something_else` is unimportant and is ignored by the compiler.

In this case, `something_else` did not exist as a variable, but including it in this context gave no error *(test this in the REPL if you doubt it)*.

Such short-circuit evaluation is quite often used by Julia programmers as a shortcut to trap runtime problems and edge cases:

```julia
all_ok || do_something()

is_problem && do_something_else()
```

For example, the `do_something` might be an early `return` from the function if `all_ok` is `false`, or assigning a default value to a variable before continuing.

This is a slight abuse of Boolean syntax, but it can be very convenient.

## How Bools work internally

If a Bool is included in an *arithmetic* expression, `true` is interpreted as `1` and `false` as `0`, reflecting how they are stored.

If you are used to lower-level languages (C and similar), *please* avoid using this often.
It will reduce code readability and make debugging harder.

You may sometimes see the numerical values used as a quick way to count how many things are `true`.

```julia-repl
julia> true + false + true
2
```

[operator-precedence]: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Operator-Precedence-and-Associativity
[boolean-operators]: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Boolean-Operators
