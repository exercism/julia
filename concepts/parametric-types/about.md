# About

In the [`Types` Concept][types], we learned that:

- Types in Julia form a hierarchy.
- Each type has a supertype.
- `Any` is at the top of the hierarchy, and is its own supertype.
- Types _may_ have subtypes, and those which do are called [`abstract types`][abstract].
- Types without subtypes (leaf nodes on the tree) are called [`concrete types`][concrete].
- Indivisible types, such as `Char` or `Int64`, are called [`primitive types`][primitive].

Only `primitive` types follow the abstract versus concrete pattern in its simple form.

One example of types which are not primitive are Collections, such as Vector or Set.

```julia-repl
julia> isprimitivetype(Int)
true

julia> isprimitivetype(Vector)
false
```

_A collection of what?_

Each Vector (or Set) is a collection of elements with some uniform type, which can either be specified with a _parameter_ in braces `{ }`, or omitted for type inference to determine.

```julia-repl
julia> v = [1, 2, 3]
3-element Vector{Int64}:
 1
 2
 3

julia> v8 = Vector{Int8}([2, 4, 6])
3-element Vector{Int8}:
 2
 4
 6
```

These [`parametric types`][parametric] are a form of [`generic programming`][generic], and many modern languages have something broadly equivalent – though with many differences in the details.

## Parametric Composite Types

Sometimes we want to create a composite type flexible (generic) enough to handle different field types.

This can be achieved with a dummy type in the definition, usually called `T`.

```julia-repl
julia> struct Point{T}
               x::T
               y::T
       end

# high definition version

julia> real_point = Point(7.3, 4.2)
Point{Float64}(7.3, 4.2)

julia> typeof(real_point)
Point{Float64}

# low definition version

julia> int8point = Point{Int8}(17, 23)
Point{Int8}(17, 23)

julia> typeof(int8point)
Point{Int8}
```

Naturally, this approach also works with collections in fields:

```julia-repl
julia> struct Record{T}
           data::Vector{T}
           comment::String
       end

julia> rec = Record{Float64}([1.3, 5.2], "some data")
Record{Float64}([1.3, 5.2], "some data")

julia> rec.data
2-element Vector{Float64}:
 1.3
 5.2

julia> rec2 = Record{Int32}([3, 5], "more data")
Record{Int32}(Int32[3, 5], "more data")

julia> rec2.data
2-element Vector{Int32}:
 3
 5
```

[types]: https://exercism.org/tracks/julia/concepts/types
[parametric]: https://docs.julialang.org/en/v1/manual/types/#Parametric-Types
[generic]: https://en.wikipedia.org/wiki/Generic_programming
[primitive]: https://docs.julialang.org/en/v1/manual/types/#Primitive-Types
[types]: "https://docs.julialang.org/en/v1/manual/types/"
[isa]: https://docs.julialang.org/en/v1/base/base/#Core.isa
[abstract]: https://docs.julialang.org/en/v1/base/base/#abstract%20type
[concrete]: https://docs.julialang.org/en/v1/manual/types/#Type-Declarations
