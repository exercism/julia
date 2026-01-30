# Introduction

In many object-oriented languages, it is common to extend behaviors by [subclassing][wiki-subclass] a parent class, inheriting methods from the parent while also adding new ones.
Thus we get an object hierarchy.

Julia _has no classes_, so by extension it _has no subclasses_.
How do we inherit and extend existing behaviors?

We saw in previous concepts how to create a type hierarchy, as well as learning how Julia uses [multiple dispatch][concept-multiple-dispatch] to choose methods based on argument types.

Julia also has several informal interfaces, which let your custom types hook into behaviors already defined for standard types.

This is most easily illustrated with the Iterator interface.

## Iterators

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

Methods for standard types are already defined: `Vector`, `Range`, `Set`, etc (currently 14 types in total).

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

Now we can define the `iterate()` methods for this type, but what is `state`?

It is up to you to decide what information you need to keep track of.
In this case, we need the most recent power of `n`, and how many items in the sequence have been returned so far.
These two numbers are wrapped in the `state` tuple, to define `iterate(P::Powers, state)`.

To get the first item, some iterators need a complicated setup.
Quite often, we just need to define a simple starting condition.
In this case, 1 is the base number to be repeatedly multipled by `n`, and there are 0 previous items.

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

So far, we already have some useful functionality: for the first 4 powers of 3, we can loop through the results, check if a given number is in the results, and apply aggregate functions such as `sum()`.

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
ERROR: MethodError: no method matching length(::Powers) (from the documentation][ref-interfaces])
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

## Summary

Interfaces are quite confusing to explain, because the Julia approach is so different to most other languages.
In particular, the name of the interface might never be mentioned in the implementation: very unlike [subclassing][wiki-subclass] or [mixins][wiki-mixins].

However, they are surprisingly simple in practice:

1. Define a suitable type.
2. Find out which methods are required.
3. Implement those methods for your custom type; typically just a few methods, and quite short and simple.
4. Let [Multiple Dispatch][concept-multiple-dispatch] take care of the rest, automatically.


[concept-multiple-dispatch]: https://exercism.org/tracks/julia/concepts/multiple-dispatch
[wiki-subclass]: https://en.wikipedia.org/wiki/Inheritance_(object-oriented_programming)#Subclasses_and_superclasses
[concept-multi-dimensional-arrays]: https://exercism.org/tracks/julia/concepts/multi-dimensional-arrays
[concept-loops]: https://exercism.org/tracks/julia/concepts/loops
[concept-vector-operations]: https://exercism.org/tracks/julia/concepts/vector-operations
[concept-hof]: https://exercism.org/tracks/julia/concepts/higher-order-functions
[concept-comprehensions]: https://exercism.org/tracks/julia/concepts/comprehensions
