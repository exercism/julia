# About

Far back in the [Vectors][vectors] Concept, we noted that "_arrays can be of arbitrary size (subject only to memory constraints in your hardware), and can have arbitrarily many dimensions._"

Since then, we have largely ignored arrays with more than one dimension, just to keep things simple.
This will make more sense if you try reading the Julia reference documents, in their full complexity.

However, higher dimensional arrays are _very, very_ important in scientific computing, so we need to understand them.

***Nomenclature:*** Following centuries of mathematical precedent, we refer to 1-D arrays as `Vectors` and 2-D arrays as `Matrices`.

Examples in this document will mostly be matrices.
Working with 3 or more dimensions is syntactically near-identical, but the output is difficult and confusing to read (on a 2-D screen).

## Constructing arrays

We have created lots of vectors by putting a comma-separated list in square brackets.
Semicolons can also be used as the separator.

```julia-repl
julia> v = [1, 2, 3]
3-element Vector{Int64}:
 1
 2
 3

julia> w = [1; 2; 3]
3-element Vector{Int64}:
 1
 2
 3

julia> v == w
true
```

If we use space (or tab) as separator, the result is different.

```julia-repl
julia> u = [1 2 3]
1×3 Matrix{Int64}:
 1  2  3
```

Julia now defines this as a 1×3 Matrix (in other contexts, we would call it a row vector).

In general, spaces join things horizontally, semicolons join things vertically.

The reference to "things" is deliberately vague, as Julia will try to work with what you give it.

```julia-repl
julia> [v 2v]
3×2 Matrix{Int64}:
 1  2
 2  4
 3  6

julia> [v; 2v]
6-element Vector{Int64}:
 1
 2
 3
 2
 4
 6
```

There are functions [`hcat()`][hcat] and [`vcat()`][vcat] that do the same thing, making more expicit that these are horizontal and vertical concatenations.
The higher-dimensional generalization is the [`cat()`][cat] function.

```julia-repl
jjulia> hcat(v, 2v)
3×2 Matrix{Int64}:
 1  2
 2  4
 3  6

julia> vcat(v, 2v)
6-element Vector{Int64}:
 1
 2
 3
 2
 4
 6
```

Typing explicit matrices is conveniently done in row-major order, because that fits with human intuition (easier to look at, for cultures with horizontal text):

```julia-repl
julia> m = [1 2 3; 4 5 6]
2×3 Matrix{Int64}:
 1  2  3
 4  5  6
```

However, be aware that Julia (like Fortran, R and Matlab, but _unlike_ C/C++ or NumPy) stores N-dimension arrays in [column-major order][col-major], and this can make a huge performance difference if you loop over the elements.
_Help your CPU cache to help you!_

```julia-repl
# put these integers in 2 rows and 3 columns

julia> reshape(collect(1:6), 2, 3)
2×3 Matrix{Int64}:
 1  3  5
 2  4  6
```

The example above takes the integers 1 to 6 and fills in a 2×3 Matrix with them column-wise.

There are various [utility functions][array-construct] to construct common types of array (uniform or random).

```julia-repl
julia> zeros(2, 3)  # see also ones()
2×3 Matrix{Float64}:
 0.0  0.0  0.0
 0.0  0.0  0.0

julia> falses(2, 2)  # booleans, see also trues()
2×2 BitMatrix:
 0  0
 0  0

julia> rand(Float32, 2, 3)  # random numbers in the interval [0, 1)
2×3 Matrix{Float32}:
 0.768823  0.169633  0.632565
 0.388451  0.109176  0.850381
```

## Indexing

For a 2-D array, we generally use two indices in `[row, col]` order.

```julia-repl
julia> m
2×3 Matrix{Int64}:
 1  2  3
 4  5  6

julia> m[1, 2] # row 1, col 2
2

# Stay within bounds! There is no row 3.
julia> m[3, 1]
ERROR: BoundsError: attempt to access 2×3 Matrix{Int64} at index [3, 1]

julia> m[3]
2
```

The last example is perhaps surprising: a _single_ index is not an error, and returns a single element.

The explanation goes back to the comment about column-major order: Julia goes down col 1, then col 2, until it finds the 3rd element _in memory_.

Be careful: this has some uses when writing general-purpose libraries, but is more likely to be confusing!

A similar issue arises when querying the size of an array.
[`length()`][length] gives the total number of elements, [`size()`][size] gives a tuple of [`ndims()`][ndims] elements with the length of each dimension.

```julia-repl
julia> m
2×3 Matrix{Int64}:
 1  2  3
 4  5  6

julia> length(m)
6

julia> size(m)  # 2 rows, 3 cols
(2, 3)

julia> ndims(m)  # how many dimensions? Like `m |> size |> length`
2
```

### Indexing with ranges and arrays

We can easily copy a sub-matrix. 

In the example below, the [`reshape()`][reshape] function coerces an array to the specified dimensions by filling column-wise, then we slice it.

```julia-repl
julia> m12 = reshape(collect(1:12), 4, 3)
4×3 Matrix{Int64}:
 1  5   9
 2  6  10
 3  7  11
 4  8  12

julia> m12[2:4, 1:2]
3×2 Matrix{Int64}:
 2  6
 3  7
 4  8

# some rows, all columns
julia> m12[2:4, :]
3×3 Matrix{Int64}:
 2  6  10
 3  7  11
 4  8  12
```

A `:` by itself means "copy everything in this dimension".

Use vectors for non-consecutive rows/cols:

```julia-repl
julia> m12[[1, 3], :]  # rows 1 and 3
2×3 Matrix{Int64}:
 1  5   9
 3  7  11
```

## Applying functions to an array

We have previously seen aggregation functions such as [`sum()`][sum] and [`maximum()`][max] applied to 1-D collections, where they operate on all the elements and return a scalar result.

This also works in higher dimensions.
However, we may want to apply the function to only one dimension, for example by summing down or across to return an array with a `singleton dimension` of size 1.

For this, there is an optional `dims` keyword argument.

```julia-repl
julia> m
2×3 Matrix{Int64}:
 1  2  3
 4  5  6

julia> sum(m)  # sum everything
21

julia> sum(m; dims=1)  # sum down
1×3 Matrix{Int64}:
 5  7  9

julia> sum(m; dims=2)  # sum across
2×1 Matrix{Int64}:
  6
 15

# other aggregation functions are similar
julia> maximum(m; dims=2)
2×1 Matrix{Int64}:
 3
 6
```

The value of `dims` is the _dimension that becomes singleton_, so `1 => 1×3` and `2 => 2×1` in the above examples.

By extension, higher-dimensional arrays can reduce multiple dimensions, if `dims` is set to an array or range _(again, understanding the output may need some thought!)_.

## Writing dimension-aware functions

The `dims` keyword argument is common in built-in functions like [`sum()`][sum], but how do we write something equivalent in our own code?

One good answer is to use higher-order functions such as [`reduce()`][reduce], and this will be covered in some detail in a later Concept.

Alternatively, Julia provides several functions that let us treat N-dimensional arrays as if they were nested vectors of vectors.

For matrices, [`eachrow()`][eachrow] and [`eachcol()`][eachcol] are convenient, but the more general function is [`eachslice()`][eachslice] that can handle arbitrary dimensions.

```julia-repl
# m is as in the previous examples

julia> eachrow(m)
2-element RowSlices{Matrix{Int64}, Tuple{Base.OneTo{Int64}}, SubArray{Int64, 1, Matrix{Int64}, Tuple{Int64, Base.Slice{Base.OneTo{Int64}}}, true}}:
 [1, 2, 3]
 [4, 5, 6]

julia> eachcol(m)
3-element ColumnSlices{Matrix{Int64}, Tuple{Base.OneTo{Int64}}, SubArray{Int64, 1, Matrix{Int64}, Tuple{Base.Slice{Base.OneTo{Int64}}, Int64}, true}}:
 [1, 4]
 [2, 5]
 [3, 6]
```

The type is a bit alarming, but only because this is a _view_ into the original array, letting us work on it without copying.
Julia arrays can potentially be Terabytes in size, so copying is potentially a performance nightmare!

A view like this can be used for looping, broadcasting, or all the other operations we saw in the syllabus so far.

Also, comprehensions can be powerful and versatile with array input.
Simple cases were mentioned in the [Loops][loops] concept, but there will be an expanded discussion in a later concept.

## Broadcasting in multiple dimansions

We discussed the 1-D case in the [Vector Operations][vector-ops] concept.

```julia-repl
julia> v = [1.2, 1.5, 1.7]
3-element Vector{Float64}:
 1.2
 1.5
 1.7

julia> v .- 0.5
3-element Vector{Float64}:
 0.7
 1.0
 1.2
```

The dotted operator `.-` treats the singleton `0.5` as equivalent to `[0.5, 0.5, 0.5]` by [`broadcasting`][broadcasting] it to match dimensions, then does the subtraction element-wise.

Extending this to higher dimensions is really just more of the same.

You may feel at first that the scope for programmer confusion scales exponentially in the number of dimensions, but practice helps a lot.
Also, familiarity with NumPy arrays translates quite well to Julia, despite the different syntax.

```julia-repl
julia> m
2×3 Matrix{Int64}:
 1  2  3
 4  5  6

julia> m .* [1.0 1.5 2.0]  # broadcast a row vector down
2×3 Matrix{Float64}:
 1.0  3.0   6.0
 4.0  7.5  12.0

julia> m ./ [1, 2]  # broadcast a column vector across
2×3 Matrix{Float64}:
 1.0  2.0  3.0
 2.0  2.5  3.0

julia> (x -> x^2).(m)  # broadcast a function to all elements
2×3 Matrix{Int64}:
  1   4   9
 16  25  36
```

In general, Julia will broadcast any singleton dimension(s) to match the shape of the larger array.


[vectors]: https://exercism.org/tracks/julia/concepts/vectors
[loops]: https://exercism.org/tracks/julia/concepts/loops
[hcat]: https://docs.julialang.org/en/v1/base/arrays/#Base.hcat
[vcat]: https://docs.julialang.org/en/v1/base/arrays/#Base.vcat
[cat]: https://docs.julialang.org/en/v1/base/arrays/#Base.cat
[reduce]: https://docs.julialang.org/en/v1/base/collections/#Base.reduce-Tuple{Any,%20Any}
[eachrow]: https://docs.julialang.org/en/v1/base/arrays/#Base.eachrow
[eachcol]: https://docs.julialang.org/en/v1/base/arrays/#Base.eachcol
[eachslice]: https://docs.julialang.org/en/v1/base/arrays/#Base.eachslice
[vector-ops]: https://exercism.org/tracks/julia/concepts/vector-operations
[col-major]: https://en.wikipedia.org/wiki/Row-_and_column-major_order
[array-construct]: https://docs.julialang.org/en/v1/manual/arrays/#Construction-and-Initialization
[length]: https://docs.julialang.org/en/v1/base/arrays/#Base.length-Tuple%7BAbstractArray%7D
[size]: https://docs.julialang.org/en/v1/base/arrays/#Base.size
[ndims]: https://docs.julialang.org/en/v1/base/arrays/#Base.ndims
[reshape]: https://docs.julialang.org/en/v1/base/arrays/#Base.reshape
[sum]: https://docs.julialang.org/en/v1/base/collections/#Base.sum
[max]: https://docs.julialang.org/en/v1/base/collections/#Base.maximum
[broadcasting]: https://docs.julialang.org/en/v1/manual/arrays/#Broadcasting
