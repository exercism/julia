# About

In many object-oriented languages, it is common to extend behaviors by [subclassing][wiki-subclass] a parent class, inheriting methods from the parent while also adding new ones.
Thus we get an object hierarchy.

Julia _has no classes_, so by extension it _has no subclasses_.
How do we inherit and extend existing behaviors?

We saw in previous concepts how to create a type hierarchy, as well as learning how Julia uses [multiple dispatch][concept-multiple-dispatch] to choose methods based on argument types.

Julia also has several informal [interfaces][ref-interfaces], which let your custom types hook into behaviors already defined for standard types.

This is most easily illustrated with the Iterator interface.

## [Iterators][ref-iterators]

Previously in the syllabus, we have seen several ways that Julia can operate on each element of a collection.

- [Loops][concept-loops], such as `for item in items...`
- [Broadcasting][concept-vector-operations]: `[1, 2, 3] .- 0.5`
- [Higher order functions][concept-hof]: `map(√, [1, 4, 9])`
- [Comprehensions][concept-comprehensions]: `[x * y for x in 1:3 for y in 4:6 if isodd(x * y)]`
- [Generators][concept-comprehensions]: `(x^2 for x in 1:1e6)`, which is lazily evaluated.

Clearly, Julia knows how to step through standard collections item by item: vectors and ranges in the above examples, also Sets, Dicts, etc.

How do we add this capability to our own custom collections, especially if they can be lazily iterated like a generator?

### Minimal requirements

To create a sequence for iteration, we need (at least) two things:

1. A way to get the _first_ item.
2. A way to get the _next_ item from the current state.

Julia achieves these tasks with methods of the `Base.iterate()` function.

1. `Base.iterate(iter)` returns a tuple of the _first_ item and initial state, or `nothing` if there is no first item.
2. `Base.iterate(iter, state)` returns a tuple of the _next_ item and next state, or `nothing` if there is no next item.

[Multiple dispatch][concept-multiple-dispatch] is central to this.
The type of `iter` determines which methods are called, and the number of arguments determines whether the first or next item is returned.

Methods for standard types are already defined: `Vector`, `Range`, `Set`, etc ([currently][ref-iterations-collections] 14 types in total).

For a custom `MyType` to share the same behaviors, we need to define `Base.iterate(iter::MyType)` and `Base.iterate(iter::MyType, state)`.

That probably sounds confusing in the abstract, but can be quite simple.
For illustration, imagine that we want a type that gives powers of a given integer `n`, up to a maximum count.

First, define a custom type:

```julia-repl
julia> struct Powers
           n::Int       # base number to raise to a power
           count::Int   # maximum length of the sequence
       end
```

----
***The next bit is still contentious***

Now we can define the `iterate()` methods for this type, but what is `state`?

It is up to you to decide what information you need to keep track of.
In this case, we need the most recent power of `n`, and how many items in the sequence have been returned so far.
These two numbers are wrapped in the `state` tuple, to define `iterate(P::Powers, state)`.

To get the first item, some iterators need a complicated setup, but in this case we just need to define a simple "zeroth" state: 1 as the base number (becuase `n^0 == 1` for any value of `n`), and 0 previous items.

```julia-repl
julia> function Base.iterate(P::Powers, state)
            curr, index = state
            next = curr * P.n
            if index < P.count
                return (next, (next, index + 1))
            end
            return nothing
       end

julia> Base.iterate(P::Powers) = iterate(P, (1, 0))
```

Alternatively, we could use an optional argument for the state: `Base.iterate(P::Powers, state=(1, 0))`.

~~~~exercism/advanced
When we introduced optional arguments in the [Functions][concept-functions] concept, nothing was said about implementation.

Since then, we learned about multiple dipatch, so it now makes more sense to know that Julia automatically converts a function _with_ optional arguments to multiple methods _without_ optional arguments.

Defining `Base.iterate(P::Powers, state=(1, 0))` is exactly equivalent to defining both `Base.iterate(P::Powers, state)` and `Base.iterate(P::Powers)` separately.

[concept-functions]: https://exercism.org/tracks/julia/concepts/functions
~~~~

***End of contentious block***

----

So far, we already have some useful functionality: for the first 4 powers of 3, we can loop through the results, check if a given number is in the results, and apply aggregate function such as `sum()`.

```julia-repl
julia> for p in Powers(3, 4)
            println(p)
       end
3
9
27
81

julia> 9 ∈ Powers(3, 4) # ∈ is a synonym for in
true

julia> sum(Powers(3, 4))
120
```

### Additional methods

Despite this good start, not everything works yet.

```julia-repl
julia> [p for p in Powers(3, 4)]
ERROR: MethodError: no method matching length(::Powers)
The function `length` exists, but no method is defined for this combination of argument types.
You may need to implement the `length` method or define `IteratorSize` for this type to be `SizeUnknown`.
```

Sure enough, `length(Powers(3, 4))` gives exactly the same error message.

This is easily fixed, as the length is part of the type constructor: 4 in this case.
We just need to define `Base.length()` for this type, then we can use comprehensions and `collect()` on the sequence.

```julia-repl
julia> Base.length(P::Powers) = P.count

julia> length(Powers(3, 4))
4

julia> [p for p in Powers(3, 4)]
4-element Vector{Int64}:
  3
  9
 27
 81

julia> collect(Powers(3, 4))
4-element Vector{Any}:
  3
  9
 27
 81

julia> Set(Powers(3, 4))
Set{Int64} with 4 elements:
  81
  27
  9
  3
```

For efficiency, it is best to also define `Base.eltype()`: the element type of the result.
This allows functions such as `collect()` to pre-assign space for the output `Vector{Int}`, instead of repeatedly doing a `push!()` to a `Vector{Any}`.

Note the syntax, which you may not have seen before: this method is defined on the _type_, not an _instance_ of the type.

```julia-repl
julia> Base.eltype(::Type{Powers}) = Int
```

Iterators are not _required_ to have finite length.
Use of "infinite" sequences is more limited, but looping over them may be useful so long as there is some way to `break` out of the loop.
For example, we could define a variant of `Powers` that generated values smaller than a certain limit (perhaps `typemax(Int)`, to avoid integer overflow).

## Other interfaces

### [Indexing][ref-indexing]

The Iterators interface allows us to take an arbitrary custom type and have it behave as a sequence, just by defining a few simple methods.

Suppose we also wanted to be able to index into the sequence:

```julia-repl
julia> P = Powers(3, 4)
Powers(3, 4)

julia> P[2]
ERROR: MethodError: no method matching getindex(::Powers, ::Int64)
The function `getindex` exists, but no method is defined for this combination of argument types.
```

We can add this behavior, and the [manual][ref-indexing] explains how.

Minimally, we need to define `getindex()`.

```julia-repl
julia> function Base.getindex(P::Powers, i::Int)
          1 ≤ i ≤ P.count || throw(BoundsError(P, i))
          return p.n ^ i
       end

julia> p = Powers(3, 4)
Powers(3, 4)

julia> p[3]
27
```

We also need to define:

- `firstindex()` and `lastindex()` to support `P[begin]` and `P[end]`.
- Variants of `getindex()` to support indexing with vectors and ranges.
- In theory, `setindex!()`, though it is hard to see what that would even mean in this example.

However, by this point we are doing a lot of work just to make our iterator look more like a Vector.

### [AbstractArray][ref-abstractarray]

It may be worth thinking about alternative interfaces that provide a better starting point.

In this case, we could consider making `Powers` a subtype of [`AbstractArray`][ref-abstractarray], which gives us a lot of array-like behavior for free.

For the `Powers` sequence, the corresponding array is of integers, with 1 dimension.
You will sometimes see this written `AbstractArray{Int, 1}`, but the aliases `AbstractVector{Int}` for 1-D and `AbstractMatrix{Int}` for 2-D are more common in newer Julia code.

```julia-repl
julia> struct PowersArray <: AbstractVector{Int}
           n::Int
           count::Int
       end
```

Rather than `length()`, we now need to define `size()` with a tuple of lengths along each dimension: only one dimension in this case.

```julia-repl
julia> Base.size(PA::PowersArray) = (PA.count,)
```

How do we want to index the entries?
In the [Multi Dimensional Arrays Concept][concept-multi-dimensional-arrays] we introduced the two main approaches:

- One index per dimension, so `M[row, col]` for a Matrix `M`.
- A single index, corresponding to the layout of entries in memory

These are called `Cartesian` and `Linear` respectively.

We only have one dimension in the example, so linear indexing is appropriate.

```julia-repl
julia> Base.IndexStyle(::Type{PowersArray}) = IndexLinear()

julia> Base.getindex(PA::PowersArray, i::Int) = PA.n ^ i

julia> p = PowersArray(3, 4)
4-element PowersArray:
  3
  9
 27
 81

julia> p[3]
27
```

Note that we did not define `iterate()` in this case.
Julia supplies a default implementation automatically, based on our definition of `getindex()`.

Defining our own version of `iterate()` is still possible, and in some cases might be more efficient.

Using the `AbstractArray` interface is especially valuable if we want higher-dimensional iteration.
At the risk of stretching the toy example beyond its breaking point, this might mean the first `m` powers of numbers in `1:n`, which will iteratively define a size `(m, n)` array.

```julia-repl
struct PowersMatrix{Int} <: AbstractMatrix{Int}
    ns::AbstractVector{Int}
    count::Int
end

Base.size(PM::PowersMatrix) = (PM.count, length(PM.ns))
Base.IndexStyle(::Type{PowersMatrix}) = IndexCartesian()
Base.getindex(PM::PowersMatrix, i::Int, j::Int) = PM.ns[j] ^ i

julia> PM = PowersMatrix(2:6, 4)
4×5 PowersMatrix{Int64}:
  2   3    4    5     6
  4   9   16   25    36
  8  27   64  125   216
 16  81  256  625  1296

julia> PM[3, 2]
27

julia> PM[7] # column major linear indexing
27

julia> PM[21]
BoundsError: attempt to access 4×5 PowersMatrix{Int64} at index [21]
[...]
```

### [Rounding][ref-rounding]

Previous concepts have mentioned various sorts of rounding for numeric types.

```julia-repl
julia> round(1.7)
2.0

julia> floor(1.7)
1.0

julia> ceil(1.7)
2.0

# specify output type
julia> round(Int, 1.7)
2

julia> round(2.4 + 7.3im)
2.0 + 7.0im
```

The [`round()`][ref-round] function is more flexible than this, allowing you to specify the [`RoundingMode`][ref-roundingmode] (of the 7 currently supported), decimal places in the output, and the number base.

We might want to have the same functions handle our custom types.
Commonly this means composite types such as coordinates.

```julia-repl
julia> struct Point3D
           x::Float64
           y::Float64
           z::Float64
       end

julia> p = Point3D(7.63, 9.24, 4.50)
Point3D(7.63, 9.24, 4.5)

julia> round(p)
ERROR: MethodError: no method matching round(::Point3D, ::RoundingMode{:Nearest})
The function `round` exists, but no method is defined for this combination of argument types.
```

Unsurprisingly, there is a `Rounding` interface, which minimally requires us to define `round()` for our type.

```julia-repl
julia> Base.round(P3D::Point3D, r::RoundingMode) = Point3D(round(P3D.x, r), round(P3D.y, r),round(P3D.z, r))

julia> round(p)
Point3D(8.0, 9.0, 4.0)

julia> ceil(p)
Point3D(8.0, 10.0, 5.0)
```

Because we include `RoundingMode` in the definition, `floor()` and `ceil()` work automatically.

Of course, we are free to define more complicated forms of rounding.

- We might want to round `Point3D` to be an integer distance from the origin, in the same direction.
- For angles, we might want to round to the 16 directions used by weather forecasters (_"wind SSW at 15 knots"_), meaning multiples of π/8 radians.
- We might want to add the ability to specify `digits`, `sigdigits` or `base`.
- There are [special options][ref-round-periods] for time periods

## Summary

Interfaces are quite confusing to explain, because the Julia approach is so different to most other languages.
In particular, the name of the interface might never be mentioned in the implementation: very unlike [subclassing][wiki-subclass] or [mixins][wiki-mixins].

However, they are surprisingly simple in practice:

1. Define a suitable type, deciding whether subtyping is useful or not.
2. Find out which methods are required (from the [documentation][ref-interfaces]).
3. Implement those methods for your custom type; typically just a few methods, and quite short and simple.
4. Let [Multiple Dispatch][concept-multiple-dispatch] take care of the rest, automatically.


[concept-multiple-dispatch]: https://exercism.org/tracks/julia/concepts/multiple-dispatch
[wiki-subclass]: https://en.wikipedia.org/wiki/Inheritance_(object-oriented_programming)#Subclasses_and_superclasses
[ref-interfaces]: https://docs.julialang.org/en/v1/manual/interfaces/
[ref-iterators]: https://docs.julialang.org/en/v1/manual/interfaces/#man-interface-iteration
[ref-iterations-collections]: https://docs.julialang.org/en/v1/base/collections/#lib-collections-iteration
[ref-indexing]: https://docs.julialang.org/en/v1/manual/interfaces/#Indexing
[concept-multi-dimensional-arrays]: https://exercism.org/tracks/julia/concepts/multi-dimensional-arrays
[wiki-mixins]: https://en.wikipedia.org/wiki/Mixin
[ref-abstractarray]: https://docs.julialang.org/en/v1/manual/interfaces/#man-interface-array
[ref-round]: https://docs.julialang.org/en/v1/base/math/#Base.round
[ref-roundingmode]: https://docs.julialang.org/en/v1/base/math/#Base.Rounding.RoundingMode
[ref-cust-broadcasting]: https://docs.julialang.org/en/v1/manual/interfaces/#man-interfaces-broadcasting
[ref-rounding]: https://docs.julialang.org/en/v1/manual/interfaces/#man-rounding-interface
[ref-round-periods]: https://docs.julialang.org/en/v1/stdlib/Dates/#Base.round-Tuple{Union{Day,%20Week,%20TimePeriod},%20Union{Day,%20Week,%20TimePeriod},%20RoundingMode{:NearestTiesUp}}
[concept-loops]: https://exercism.org/tracks/julia/concepts/loops
[concept-vector-operations]: https://exercism.org/tracks/julia/concepts/vector-operations
[concept-hof]: https://exercism.org/tracks/julia/concepts/higher-order-functions
[concept-comprehensions]: https://exercism.org/tracks/julia/concepts/comprehensions
