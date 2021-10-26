# Introduction

A `String` in Julia is an immutable, finite sequence of [Unicode](https://en.wikipedia.org/wiki/Unicode) characters, in [UTF-8](https://en.wikipedia.org/wiki/UTF-8) encoding.

A `String` literal is a sequence of characters enclosed in double quotes:

```julia-repl
julia> "Christopher"
"Christopher"
```

Strings can be concatenated via the `*` operator:

```julia-repl
julia> "Christopher" * " " * "Paolini"
"Christopher Paolini"
```

~~~~exercism/advanced
If you're curious why Julia uses `*` rather than `+` for string concatenation, take a look at the [Julia Manual](https://docs.julialang.org/en/v1/manual/strings/#man-concatenation).
~~~~

Some special characters need to be escaped with a leading backslash:

```julia-repl
julia> println("\t or spaces?")
         or spaces?
```

Julia includes many useful functions to work on strings by default:

```julia-repl
julia> lowercase("TEST")
"test"

julia> titlecase("TEST")
"Test"
```
