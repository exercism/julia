# Introduction

A `Tuple` is quite similar to a `Vector` (1-D `array`) in many ways.
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
ERROR: MethodError: no method matching setindex!(::Tuple{Int64, Float64, String})
```

There is also a `Tuple()` constructor, which will turn any iterable collection into a tuple.
Usefully, this treats a string as an iterable collection of characters.

```julia-repl
julia> Tuple("Julia")
('J', 'u', 'l', 'i', 'a')
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

Python programmers will be very familiar with this multiple-assignment syntax.

## Named tuples

A `Tuple` contains only values.
A `NamedTuple` pairs each value with a name.

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

The name is stored internally as a `Symbol` (an immutable type, and the name is prefixed with a colon `:`), so there is an alternative syntax available:

```julia-repl
julia> nt[:b]
7.3
```

It is easy to get either the names (also called "keys") or values separately:

```julia-repl
julia> nt
(a = 1, b = 7.3)

julia> keys(nt)
(:a, :b)

julia> values(nt)
(1, 7.3)
```

Note that iteration over a named tuple only produces the _values_, and the _names_ are ignored.

Tuples (named or not) are a very common way to transfer structured data to and from functions.
Immutability is good in this use case, providing data safety and allowing more aggressive compiler optimizations.

