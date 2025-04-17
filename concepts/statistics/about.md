# About

"Statistics" is a large and complex subject with many aspects.

Some aspects were touched on in the [`Randomness`][randomness] concept, which is a separate but related subject.

At its simplest, statistics can involve ways to summarize an iterable collection of data in a single value.
Newcomers to Julia may be surprised at how few functions are built in to the language by default:

- [`sum`][sum], to add up numbers.
- [`min`][min] and [`max`][max], to get the extreme values of the given parameters.
- [`extrema`][extrema], to get the (min, max) tuple of an iterable.
- [`length`][length], to count all values.
- [`count`][count], to count only values meeting some criterion.

```julia-repl
julia> v = collect(1:0.2:3)
11-element Vector{Float64}:
 1.0
 1.2
 ... # display truncated
 3.0

julia> mean(v)
2.0

julia> extrema(v)
(1.0, 3.0)

julia> length(v)
11

julia> min('g', 'a', 'c')
'a': ASCII/Unicode U+0061 (category Ll: Letter, lowercase)

julia> count(isodd, 1:5)  # 1, 3, and 5 are odd
3
```

This limited set of functions is a deliberate decision to minimize bloat in base Julia by moving other functions out to a cascade of other modules and packages.

## The `Statistics` module

As part of the standard library, [`Statistics`][statistics] is likely to be pre-installed, so just needs `using Statistics` added to the top of the program to bring it into the namespace.

This module contains the next tier of common functions, which are likely to be widely used by a subset of programmers.

Many of the functions in `Statistics` assume some background knowledge of the subject.
The simplest examples include:

- [`mean`][mean], which many people would call the average (same result as `sum / length`).
- [`median`][median], the middle value after sorting.
- [`std`][std], [standard deviation][stddev]: a measure of how widely spread the values are.
- [`var`][var], variance: the square of `std`, which is generally quicker to calculate.

Each function tends to have various options, and there are _many_ more functions, so check the [documentation][statistics] if interested.

## Other packages

As you might expect, statistics is a big use-case for Julia, and there many available packages to support more specialized work.

The JuliaStats group helpfully maintain an [online list][juliastats].

[statistics]: https://docs.julialang.org/en/v1/stdlib/Statistics/
[randomness]: https://exercism.org/tracks/julia/concepts/randomness
[sum]: https://docs.julialang.org/en/v1/base/collections/#Base.sum
[min]: https://docs.julialang.org/en/v1/base/math/#Base.min
[max]: https://docs.julialang.org/en/v1/base/math/#Base.max
[extrema]: https://docs.julialang.org/en/v1/base/collections/#Base.extrema
[length]: https://docs.julialang.org/en/v1/base/collections/#Base.length
[count]: https://docs.julialang.org/en/v1/base/collections/#Base.count
[mean]: https://docs.julialang.org/en/v1/stdlib/Statistics/#Statistics.mean
[median]: https://docs.julialang.org/en/v1/stdlib/Statistics/#Statistics.median
[std]: https://docs.julialang.org/en/v1/stdlib/Statistics/#Statistics.std
[var]: https://docs.julialang.org/en/v1/stdlib/Statistics/#Statistics.var
[stddev]: https://en.wikipedia.org/wiki/Standard_deviation
[juliastats]: https://juliapackages.com/u/juliastats
