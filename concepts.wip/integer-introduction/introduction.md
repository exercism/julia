# Introduction

Integer literals in Julia are represented in the usual way.
Underscores may be used as a digit separator.

```julia-repl
julia> 1
1

julia> -1234
-1234

julia> 1_234_567_890
1234567890
```

## Arithmetic operations

The standard prefix and infix operations are available: `+`, `-`, `*`, `%`.

```julia-repl
julia> +16
16

julia> -16
-16

julia> 16 + 6
22

julia> 16 - 6
10

julia> 16 * 6
96

julia> 16 % 6
4
```

### Division

Dividing two numbers with the `/` operator will result in a floating point value.
To perform integer division

- use the `div(x, y)` function, or
- use the `÷` operator (Julia source code is unicode-aware)

```julia-repl
julia> 16 / 6
2.6666666666666665

julia> div(16, 6)
2

julia> 16 ÷ 6
2
```

~~~~exercism/note
It's natural to use Unicode symbols in Julia source files, typically in mathematical expressions.
When using the Julia REPL, or in other Julia editing environments, the division symbol can be entered by typing `\div` followed by the `Tab` key.
More details can be found in the manual at [Unicode Input][unicode].

[unicode]: https://docs.julialang.org/en/v1/manual/unicode-input/#Unicode-Input
~~~~
