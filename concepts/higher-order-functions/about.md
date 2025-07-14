# About

Technically, a `Higher Order Function` is simply a function which does at least one of:

- Accepts a function as one of its arguments.
- Returns a function as its result.

Within the world of functional programming, usage tends to be narrower.
The term usually refers to functions such as `filter`, `map` and `reduce` which apply a function across the elements of a collection.

## Operating on collections

By this point in the syllabus, we already saw various ways to apply some operation to all elements of some iterable collection, such as a Vector:

- Use a [loop][loops] (like most programming languages since the dawn of digital computing).
- Use a [comprehension][comprehensions] (Python-style).
- Use [broadcasting][broadcasting] (distinctively Julia syntax, though with a debt to R and NumPy).

This Concept will focus on higher-order functions (familiar from any functional language, such as Haskell or F#).

Other possible approaches include:

- Recursion (as in ML-family languages). Julia allows this, but without tail-recursion optimization it risks stack overflow.
- Metprogramming with macros (traditionally a Lisp feature). This is widely used in advanced Julia programming, but approach with caution in most cases. Other options are likely to be easier to write and much easier to debug.

## Filtering

The [`filter()`][filter] function takes a function with a boolean return value and applies it along a collection.
Only elements returning `true` are included in the return value.

```julia-repl
julia> filter(iseven, 1:6)
3-element Vector{Int64}:
 2
 4
 6

julia> filter(!isascii, "Hrōðgār")
"ōðā"
```

The examples above use built-in functions, but use of anonymous functions is very common in this context.

```julia-repl
julia> filter(x -> x % 3 == 0, 1:20)
6-element Vector{Int64}:
  3
  6
  9
 12
 15
 18
```

There is also an in-place version, [`filter!()`][filter-bang], as there is for most of the functions in this Concept.

## Mapping

The [`map()`][map] function transforms a collection by applying a function to each element.
This can be similar to [broadcasting][broadcasting] in simple cases, though differences become important with multidimensional collections.

```julia-repl
julia> map(√, [1, 4, 9])
3-element Vector{Float64}:
 1.0
 2.0
 3.0

julia> map(x -> x^2 + 1, 1:4)
4-element Vector{Int64}:
  2
  5
 10
 17
```

`map()` will also operate element-wise on multiple collections.

```julia-repl
julia> map(*, [1, 2], [3, 4])
2-element Vector{Int64}:
 3
 8
```

Conceptually, we can think of this as equivalent to running [`zip()`][zip] on the input collections, then `map()` on each element of the intermediate result.
_This is only a rough analogy, implying nothing about the implementation!_

As with `zip()`, collections of mismatched shape are truncated to the dimension(s) of the smallest.

Sometimes only the side effects of the passed-in function are needed, such as a database write or a `push!` to an array..
Then the more efficient higher-order function is [`foreach()`][foreach], which returns `nothing`.

For large collections, `map()` can be expensive.

Parallel computing is outside the scope of this Concept, but it may be useful to know that [`Distributed.pmap()`][pmap] exists and can spread the computation over a pool of workers.
The `Distributed` package _is_ available in the Exercism test runner.

## Reducing

The [`reduce()`][reduce] function takes a 2-argument function and applies it to a collection, leading to a dimension-reduction.

That may sound confusing in the abstract, but consider functions like `sum()` or `prod()` which take in a collection and return a single value.

```julia-repl
julia> sum(1:4) # add
10

julia> prod(1:4) # multiply
24
```

_These special functions are highly optimized and should always be used when available._
Other examples include `maximum()` and `minimum()`, logical functions `all()` and `any()`, and many statistical functions.

_For illustration only_, consider the same functionality implemented with the more generic `reduce()` _(recall that infix operators `+` and `*` are really functions internally)_.

```julia-repl
julia> reduce(+, 1:4) # add
10

julia> reduce(*, 1:4) # multiply
24
```

These are easy examples, because add and multiply are both commutative (`1+2 == 2+1`) and associative ( `(1+2)+3 == 1+(2+3)` ).

This is far from universal!
Even such common operations as minus and divide are non-associative.

There is the additional problem that floating-point errors can accumulate across large collections, so a left-to-right reduce may produce a slightly different answer than right-to-left.

The direction of Julia's `reduce` function is implementation-dependent and not guaranteed.

To control direction explicitly, there are [`foldl()`][foldl] and [`foldr()`][foldr] functions.

```julia-repl
julia> foldl(-, 1:3) # (1 - 2) - 3
-4

julia> foldr(-, 1:3) # 1 - (2 - 3)
2
```

For such simple examples, this may seem like more functions than we need to do essentially the same thing.

The situation will become more nuanced with some later concepts:

- N-dimensional arrays, which can be sliced and reduced in many ways.
- Parallel computing, where out-of-sequence calculations are normal.

## MapReduce

Combining a `map` operation with a `reduce` is very common in various programming domains.

We could sequentially run `map`, then run `reduce` on an intermediate collection.
However, this is inefficient at best, and scales very badly as the collection gets larger.

It is _strongly_ recommended to use the combined [`mapreduce()`][mapreduce] function instead, because it can use a much more performant algorithm which interleaves the map/reduce operations.

Thefirst argument is the function to map with, the second argument is the reduce operator.

```julia-repl
julia> mapreduce(x -> x^2 + 1, +, 1:3)
17

# equivalent to (2 + 5 + 10)
julia> sum(map(x -> x^2 + 1, 1:3))
17
```

MapReduce operations are especially popular with big data systems (Hadoop, Spark, etc), as they can operate in real time on streams of arbitrary and unknown length without exploding memory usage.

As we might expect, Julia also has [`mapfoldl()`][mapfoldl] and [`mapfoldr()`][mapfoldr] functions for sitations where direction is important.



[loops]: https://exercism.org/tracks/julia/concepts/loops
[broadcasting]: https://exercism.org/tracks/julia/concepts/vector-operations
[comprehensions]: https://exercism.org/tracks/julia/concepts/loops
[zip]: https://docs.julialang.org/en/v1/base/iterators/#Base.Iterators.zip
[filter]: https://docs.julialang.org/en/v1/base/collections/#Base.filter
[filter-bang]: https://docs.julialang.org/en/v1/base/collections/#Base.filter!
[foreach]: https://docs.julialang.org/en/v1/base/collections/#Base.foreach
[map]: https://docs.julialang.org/en/v1/base/collections/#Base.map
[pmap]: https://docs.julialang.org/en/v1/stdlib/Distributed/#Distributed.pmap
[reduce]: https://docs.julialang.org/en/v1/base/collections/#Base.reduce-Tuple{Any,%20Any}
[foldl]: https://docs.julialang.org/en/v1/base/collections/#Base.foldl-Tuple{Any,%20Any}
[foldr]: https://docs.julialang.org/en/v1/base/collections/#Base.foldr-Tuple{Any,%20Any}
[mapreduce]: https://docs.julialang.org/en/v1/base/collections/#Base.mapreduce-Tuple%7BAny,%20Any,%20Any%7D
[mapfoldl]: https://docs.julialang.org/en/v1/base/collections/#Base.mapfoldl-Tuple{Any,%20Any,%20Any}
[mapfoldr]: https://docs.julialang.org/en/v1/base/collections/#Base.mapfoldr-Tuple{Any,%20Any,%20Any}

