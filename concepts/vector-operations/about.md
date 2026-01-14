# About

In the [`Vectors`][vectors] Concept, we said that "arrays are at the heart of the Julia language" and a vector is a 1-dimensional array.

Given this, we could reasonably hope that the language provides many versatile and powerful ways to _do things_ with vectors, whatever that means.

A note on terminology: though this document talks a lot about "vectors", much of it also applies to any iterable type: [ranges][ranges], [tuples][tuples], [sets][sets], and various others.

## Functions expecting vector input

Some very simple functions take a vector input and (for 1-D input) return a scalar output.

```julia
v = [2, 3, 4]
length(v)  # => 3
sum(v)  # => 9
```

When we reach the Concept on [multidimensional arrays][concept-multi-dimensional-arrays], it will become clearer that this is _dimension reduction_ rather than necessarily returning a scalar.
If that makes no sense to you, skip worrying about it for now.

There are many more functions of this type.
See the [`Statistics`][statistics] Concept for some examples.

There are also functions that operate on multiple vectors, such as the (very useful) [`zip`][zip].

```julia-repl
julia> z = zip( 1:3, ['a', 'b', 'c'], ["I", "make", "tuples"] )
zip([1, 2, 3], ['a', 'b', 'c'], ["I", "make", "tuples"])

# convert iterator to vector
julia> collect(z)
3-element Vector{Tuple{Int64, Char, String}}:
 (1, 'a', "I")
 (2, 'b', "make")
 (3, 'c', "tuples")
```

`zip()` takes an arbitrary number of vector-like inputs and returns an iterator of tuples.

The inputs are usually all the same length.
If one is shorter, the others are truncated to the shortest length: _maybe_ what you intended, but _more commonly_ a bug in your code.

## Arithmetic

Suppose you have a numerical vector and want to subtract 0.5 from each value.

```julia-repl
julia> v = [1.2, 1.5, 1.7]
3-element Vector{Float64}:
 1.2
 1.5
 1.7

julia> v - 0.5
ERROR: MethodError: no method matching -(::Vector{Float64}, ::Float64)
```

That fails, so what about subtracting another vector?

```julia-repl
julia> v - [0.5, 0.5, 0.5]
3-element Vector{Float64}:
 0.7
 1.0
 1.2
```

Successful, but quite tedious and memory-hungry as the vectors get longer.

Depending on how far you have reached in the syllabus, you can probably think of other approaches:

- Write a loop, though this would be verbose and clunky.
- Use a comprehension: `[x - 0.5 for x in v]` gives the desired result (Python-style).
- Use a higher-order function: `map(x -> x - 0.5, v)` also works (Haskell-style, though common in many languages).

Fortunately, Julia has a "magic" dot to solve this problem very simply: `v .- 0.5` is all you need.

The next section explains why.

## [Broadcasting][broadcasting]

So, `v - 0.5` fails but `v .- 0.5` succeeds, and we need to understand what the dot is doing.

Two things, which combine to give the desired result.

### 1) Element-wise application

Firstly, adding a dot _before_ any infix operator means "apply this operation to each element separately".

Similarly, adding a dot _after_ a function name "vectorizes" it, even if the function was written for scalar inputs.

```julia-repl
julia> sqrt.([1, 4, 9])
3-element Vector{Float64}:
 1.0
 2.0
 3.0
```

As an aside, infix operators are really just syntactic sugar for the underlying function.

This means that, for example, `[1, 5, 10] .% 3` is translated to ` mod.([1, 5, 10], 3)` by the interpreter, and the `mod.` syntax then executes (both versions return `[1, 2, 1]`).

### 2) Singleton expansion

We saw in a previous example that we can subtract vectors of equal length, though please understand that `.-` is a _safer_ operator than `-` by making the element-wise intention clear.

```julia-repl
julia> v .- [0.5, 0.5, 0.5]
3-element Vector{Float64}:
 0.7
 1.0
 1.2
```

What about vectors of unequal length?

```julia-repl
julia> v .- [0.5, 0.5]
ERROR: DimensionMismatch: arrays could not be broadcast to a common size

julia> v .- [0.5,]
3-element Vector{Float64}:
 0.7
 1.0
 1.2
```

In general, unequal lengths are an error, _except_ when one has length 1 (technically, a "singleton" dimension).

Singletons like `[0.5,]` or just `0.5` are automatically expanded to the necessary length by repetition.
This is at the heart of `broadcasting`.

Anyone worrying about memory usage from this "repetition" can relax: it is implemented in a very efficient way that does not actually copy the values in memory.

Programmers familiar with broadcasting in other languages should note that Julia's approach is (mostly) similar to NumPy, but much less tolerant of size mismatches than R.

### Broadcasting in-place

If memory usage is a concern, then in-place operations are a common way to look to reduce allocations.
However, the broadcasting operations in the examples above create a new `Vector` instead of modifying the original.

```julia-repl
julia> v = [1, 2, 3]
3-element Vector{Int64}:
 1
 2
 3

julia> v .+ 1
3-element Vector{Int64}:
 2
 3
 4

julia> v
3-element Vector{Int64}:
 1
 2
 3
```

To modify `v` in-place, the modification needs to be broadcast.

```julia-repl
julia> v .= v .+ 1
3-element Vector{Int64}:
 2
 3
 4

julia> v .+= 1  # equivalent operation to above
3-element Vector{Int64}:
 3
 4
 5

julia> v
3-element Vector{Int64}:
 3
 4
 5
```

But be careful! The dot before the assignment operator `.=` is important.

```julia-repl
julia> v = [1, 2, 3];

julia> v = v .+ 1
3-element Vector{Int64}:
 2
 3
 4

julia> v
3-element Vector{Int64}:
 2
 3
 4
```

This appears to have worked in the same way, but here `v .+ 1` created a new vector `[2, 3, 4]` and then assigned it to the variable `v`, leaving the initial vector `[1, 2, 3]` in memory to be garbage collected.
This ends up using twice as much memory as the previous example that reuses the memory allocated for the initial vector.

Likewise, there are related subtlties when broadcasting with vectors of the same size.
For example, given two vectors `v` and `w` of the same size:

- `v .= w` produces a copy of `w` in the memory location of `v`. Further changes in `v` do not affect `w` and vice versa.
- `v = w` produces another pointer to the memory location of `w` with the name `v`. Further changes in `v` are reflected in `w` and vice versa.

### Un-dotted operators: a cautionary tale

This subsection is rather math-heavy, so most students are not expected to really understand it.
However, it is a useful warning that may help with debugging when you see unexpected error messages.

```julia-repl
julia> v = [1, 2, 3]
3-element Vector{Int64}:
 1
 2
 3

julia> v * v
ERROR: MethodError: no method matching *(::Vector{Int64}, ::Vector{Int64})

# look, no commas
julia> u = [1 2 3]
1×3 Matrix{Int64}:
 1  2  3

julia> u * v
1-element Vector{Int64}:
 14

julia> v * u
3×3 Matrix{Int64}:
 1  2  3
 2  4  6
 3  6  9
```

If you happen to have a background in linear algebra then (1) you are not a typical Exercism user _(but very welcome here!)_ and (2) you may recognize that `v` is a column vector, `u` is a row vector, `u * v` is the inner product and `v * u` is the outer product.
_Julia follows the rules of mathematics, in this as in everything_.

**For everyone else:** please just understand why we recommend you should always use dotted operators for element-wise calculations: `v .* v` works exactly as you might expect, to give `[1, 4, 9]`.

## Indexing

Selecting elements of a vector by index number has been discussed in previous Concepts.

```julia
a = collect('A':'Z')  # => 26-element Vector{Char}

# index with an integer
a[2]  # => 'B'

# index with a range
 a[12:2:18]  # => ['L', 'N', 'P, 'R']
 
 # index with another vector
 a[ [1, 3, 5] ]  # => ['A', 'C', 'E']
```

### Logical indexing

It is also possible to select elements that satisfy some logical expression (technically, a "predicate").
This usually requires broadcasting.

```julia-repl
julia> a[a .< 'D']
3-element Vector{Char}:
 'A': ASCII/Unicode U+0041 (category Lu: Letter, uppercase)
 'B': ASCII/Unicode U+0042 (category Lu: Letter, uppercase)
 'C': ASCII/Unicode U+0043 (category Lu: Letter, uppercase)
```

For more complex expression the dots tend to proliferate (but they are small and easy to type).

```julia-repl
julia> a[a .< 'D' .|| a .> 'W']
6-element Vector{Char}:
 'A': ASCII/Unicode U+0041 (category Lu: Letter, uppercase)
 'B': ASCII/Unicode U+0042 (category Lu: Letter, uppercase)
 'C': ASCII/Unicode U+0043 (category Lu: Letter, uppercase)
 'X': ASCII/Unicode U+0058 (category Lu: Letter, uppercase)
 'Y': ASCII/Unicode U+0059 (category Lu: Letter, uppercase)
 'Z': ASCII/Unicode U+005A (category Lu: Letter, uppercase)
```

A reminder that the "vector" can in fact be any appropriate ordered iterable, such as a range:

```julia-repl
julia> n = 3:10
3:10

julia> n[isodd.(n)]
4-element Vector{Int64}:
 3
 5
 7
 9
```

Internally, the predicate is converted to a [`BitVector`][bitarray] which is then used as an index.

```julia-repl
julia> condition = a .< 'D'
26-element BitVector:
 1
 1
 1
 0
 # display truncated

julia> a[condition]
3-element Vector{Char}:
 'A': ASCII/Unicode U+0041 (category Lu: Letter, uppercase)
 'B': ASCII/Unicode U+0042 (category Lu: Letter, uppercase)
 'C': ASCII/Unicode U+0043 (category Lu: Letter, uppercase)
```

[vectors]: https://exercism.org/tracks/julia/concepts/arrays
[ranges]: https://exercism.org/tracks/julia/concepts/ranges
[sets]: https://exercism.org/tracks/julia/concepts/sets
[tuples]: https://exercism.org/tracks/julia/concepts/tuples
[statistics]: https://exercism.org/tracks/julia/concepts/statistics
[zip]: https://docs.julialang.org/en/v1/base/iterators/#Base.Iterators.zip
[bitarray]: https://docs.julialang.org/en/v1/base/arrays/#Base.BitArray
[broadcasting]: https://docs.julialang.org/en/v1/manual/arrays/#Broadcasting
[concept-multi-dimensional-arrays]: https://exercism.org/tracks/julia/concepts/multi-dimensional-arrays
