# Introduction

## Nothingness

`nothing` is a singleton instance of the `Nothing` type.
It is used when a function has no return value, or when a variable holds no value.

You can test if a value is `nothing` using the `isnothing` function:

```jldoctest
julia> isnothing("something")
false

julia> isnothing("")
false

julia> isnothing(nothing)
true
```

In other languages, `null`, `nil`, or `none` values may serve similar purposes.

## Source

This entire document is derived from the Julia documentation for [`nothing`](https://docs.julialang.org/en/v1/base/constants/#Core.nothing) and [`isnothing`](https://docs.julialang.org/en/v1/base/base/#Base.isnothing)
