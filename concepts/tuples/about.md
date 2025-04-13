# About

A [`Tuple`][tuple] is quite similar to a [`Vector`][vector] (1-D `array`) in many ways.
However, there are a few important differences.

- Tuples are written in parentheses `( )` instead of brackets `[ ]`, though the parentheses can be omitted in cases where the meaning is unambiguous.
- Tuples are not required to be homogeneous: the type of each element is stored independently.
- Tuples are immutable.

Immutability allows more compiler optimizations and makes tuples more performant than vectors, so they should be preferred in cases where mutability is not necessary.

```julia-repl
julia> t = (3, 5.2, "xyz")
(3, 5.2, "xyz")

# Non-homogeneous:
julia> dump(t)
Tuple{Int64, Float64, String}
  1: Int64 3
  2: Float64 5.2
  3: String "xyz"

julia> t[2]
5.2

# Immutable:
julia> t[2] = 7.3
ERROR: MethodError: no method matching setindex!(::Tuple{Int64, Float64, String}
```

For any tuple, it is possible to access elements by index or loop over them.

Any purely numerical tuple can also be used in mathematical functions such as `sum()`, exactly like arrays.

## Unpacking

A tuple can be unpacked into individual elements by using multiple assignment.
For elements that are not required, use underscore `_` as the dummy variable.

```julia-repl
julia> tup = (1, "Julia", true)
(1, "Julia", true)

julia> num, name, _ = tup
(1, "Julia", true)

julia> uppercase(name), 2num
("JULIA", 2)
```

To copy all elements of a tuple into another tuple (or a collection more generally), there is a [`splat`][splat] operator `...` to unpack it. This will be covered in more detail in the [Functions][functions] Concept.

```julia-repl
julia> new_tup = (tup..., π, '😊')
(1, "Julia", true, π, '😊')
```

## Named tuples

A [`Tuple`][tuple] contains only values.
A [`NamedTuple`][namedtuple] pairs each value with a name.

Individual fields can then be accessed with "dot" notation:

```jullia-repl
julia> nt = (a = 1, b = 7.3)
(a = 1, b = 7.3)

julia> dump(nt)
@NamedTuple{a::Int64, b::Float64}
  a: Int64 1
  b: Float64 7.3

julia> nt.b
7.3
```

The name is stored internally as a [`Symbol`][symbol] (an immutable type, and the name is prefixed with a colon `:`), so there is an alternative syntax available:

```julia-repl
julia> nt[:b]
7.3
```

It is sometimes useful to split creation of a named tuple into two steps:

1. Define the fields as as custom data type.
2. Use this as a constructor to convert a tuple to a named tuple.

```julia-repl
# Step 1
julia> Student = NamedTuple{(:name, :grade), Tuple{String, Int}}
@NamedTuple{name::String, grade::Int64}

julia> typeof(Student)
DataType

# Step 2
julia> s = Student( ("Helen", 3) )
(name = "Helen", grade = 3)

julia> dump(s)
@NamedTuple{name::String, grade::Int64}
  name: String "Helen"
  grade: Int64 3
```

There are surprisingly many other ways to create a named tuple, so check the [documentation][namedtuple] if you are interested.

It is easy to get either the names (also called "keys") or values separately:

```julia-repl
julia> keys(s)
(:name, :grade)

julia> values(s)
("Helen", 3)
```

Note that iteration over a named tuple only produces the _values_, and the _names_ are ignored.

If the names are also useful in an iteration, more steps are needed.
The `NamedTuple` can be converted to a [`Vector`][vector] of [`Pairs`][pairs] (`Pair`s are the subject of another Concept).

```julia-repl
julia> pairs(s)
pairs(::NamedTuple) with 2 entries:
  :name  => "Helen"
  :grade => 3

julia> collect(pairs(s))
2-element Vector{Pair{Symbol, Any}}:
  :name => "Helen"
  :grade => 3
```

The named tuple is thus quite dictionary-like.
However, it differs from a [`Dict`][dict] in Julia in some important ways:

- A `Dict` is mutable; a `NamedTuple`, like any tuple, is immutable.
- A `Dict` is flexible in the type of keys it accepts; a `NamedTuple` can only use symbols as keys.

Tuples (named or not) are a very common way to transfer structured data to and from functions.
Immutability is good in this use case, providing data safety and allowing more aggressive compiler optimizations.


[tuple]: https://docs.julialang.org/en/v1/base/base/#Core.Tuple
[namedtuple]: https://docs.julialang.org/en/v1/base/base/#Core.NamedTuple
[vector]: https://docs.julialang.org/en/v1/base/arrays/#Base.Vector
[pairs]: https://docs.julialang.org/en/v1/base/collections/#Core.Pair
[symbol]: https://docs.julialang.org/en/v1/base/base/#Core.Symbol
[splat]: https://docs.julialang.org/en/v1/manual/functions/#Varargs-Functions
[functions]: https://exercism.org/tracks/julia/concepts/functions
