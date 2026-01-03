# About

Julia, like most programming languages, provides a rich variety of collection types.

Some are inherently ordered (including `Vectors` and higher-dimensional `Arrays`), so we can access elements by position.
Other collections are unordered (`Sets`, `Dicts`), and elements must be accessed by key or value.

In the simplest case, suppose we have a `Vector` of `Ints`, and want to [sort][ref-sorting] it in ascending order.

```julia-repl
julia> v = [3, 2, 4, 1]
4-element Vector{Int64}:
 3
 2
 4
 1

julia> sort(v)
4-element Vector{Int64}:
 1
 2
 3
 4

# sort descending
julia> sort(v, rev=true)
4-element Vector{Int64}:
 4
 3
 2
 1
```

Simple!
The [`sort()`][ref-sort] function has an obvious name, and apparently returns the sorted `Vector`.

_Only joking!_
By this stage in the syllabus, you perhaps suspect (correctly) that there are nuances we need to discuss.

## Mutating vs non-mutating fuctions

After running `sort(v)`, what is `v`?

```julia-repl
julia> v
4-element Vector{Int64}:
 3
 2
 4
 1

julia> issorted(v)
false
```

The original vector is unchanged.
`sort()` is a ***non-mutating*** function that returns a _copy_ of its input.

This is good design in many contexts: we have a [pure function][wiki-pure-func] whose behaviour is easy to reason about, even in parallel, distributed code.

On the other hand, suppose we had an array of a billion strings, and wanted to sort it.

The sorting is probably slow (more on that later).
Additionally, we need to copy everything (_slow!_), and allocate enough memory (_several GigaBytes!_) to store the copy.

Compare this quite similar code:

```julia-repl
# v is as previously

julia> issorted(v)
false

julia> sort!(v)
4-element Vector{Int64}:
 1
 2
 3
 4

julia> v
4-element Vector{Int64}:
 1
 2
 3
 4

julia> issorted(v)
true
```

Now the input `Vector` is sorted in-place, without copying, and the original ordering is lost permanently.

This can be efficient, it can be buggy and dangerous, it can be confusing to other people using your code.
_Choose carefully!_

[`sort!()`][ref-sort!] is a [mutating function][ref-mutating-func], and by (_very strong_) convention, any function that mutates its inputs has a `!` appended to its name, as a warning to programmers.

## Sort by what?

Sorting `Int64` values is relatively simple: even young children understand that 2 is bigger than 1 and smaller than 3.

Other types may be more complicated, but in general `x < y` if `isless(x, y) == true`.
Julia provides implementations of `isless()` for most standard types, and you can define equivalent [methods][concept-multiple-dispatch] to compare your [custom types][concept-composite-types].

For example, Unicode characters (Uppercase sorts before lowercase, for European letters):

```julia-repl
julia> j = collect("Julia")
5-element Vector{Char}:
 'J': ASCII/Unicode U+004A (category Lu: Letter, uppercase)
 'u': ASCII/Unicode U+0075 (category Ll: Letter, lowercase)
 'l': ASCII/Unicode U+006C (category Ll: Letter, lowercase)
 'i': ASCII/Unicode U+0069 (category Ll: Letter, lowercase)
 'a': ASCII/Unicode U+0061 (category Ll: Letter, lowercase)

julia> sort(j)
5-element Vector{Char}:
 'J': ASCII/Unicode U+004A (category Lu: Letter, uppercase)
 'a': ASCII/Unicode U+0061 (category Ll: Letter, lowercase)
 'i': ASCII/Unicode U+0false069 (category Ll: Letter, lowercase)
 'l': ASCII/Unicode U+006C (category Ll: Letter, lowercase)
 'u': ASCII/Unicode U+0075 (category Ll: Letter, lowercase)
```

We can also apply any arbitrary function to the entries before sorting, such as [`abs`][ref-abs] to ignore sign or [`uppercase`][ref-uppercase] for case-insensitive sorting:

```julia-repl
julia> nums = [3, -2, -4, 1]
4-element Vector{Int64}:
  3
 -2
 -4
  1

julia> sort(nums)
4-element Vector{Int64}:
 -4
 -2
  1
  3

julia> sort(nums, by=abs)
4-element Vector{Int64}:
  1
 -2
  3
 -4

# j is from "Julia", as previously

julia> sort(j, by=uppercase)
5-element Vector{Char}:
 'a': ASCII/Unicode U+0061 (category Ll: Letter, lowercase)
 'i': ASCII/Unicode U+0069 (category Ll: Letter, lowercase)
 'J': ASCII/Unicode U+004A (category Lu: Letter, uppercase)
 'l': ASCII/Unicode U+006C (category Ll: Letter, lowercase)
 'u': ASCII/Unicode U+0075 (category Ll: Letter, lowercase)
```

For [multi-dimensional arrays][concept-mda], we can specify a `dims` keyword to control the direction of sorting.

```julia-repl
# create a matrix of integers in random order
julia> A = reshape(Random.shuffle(1:9), (3, 3))
3×3 Matrix{Int64}:
 8  4  9
 6  7  5
 2  1  3

julia> sort(A, dims=1)  # sort rows
3×3 Matrix{Int64}:
 2  1  3
 6  4  5
 8  7  9

julia> sort(A, dims=2)  # sort columns
3×3 Matrix{Int64}:
 4  8  9
 5  6  7
 1  2  3
```

## Sort index array

If the elements being sorted are large objects, it may be easier to work with their positional index.

```julia-repl
julia> langs = ["Julia", "C++", "Python", "Elixir"]
4-element Vector{String}:
 "Julia"
 "C++"
 "Python"
 "Elixir"

julia> inxs = sortperm(langs)  # => Integers
4-element Vector{Int64}:
 2
 4
 1
 3

julia> langs[inxs]  # sort the entire vector
4-element Vector{String}:
 "C++"
 "Elixir"
 "Julia"
 "Python"

julia> langs[inxs[1:2]]  # slice the indices
2-element Vector{String}:
 "C++"
 "Elixir"
```

Each index in `langs` is an integer in the [range][concept-range] `1:length(langs)`.
Output from [`sortperm()`][ref-sortperm] is a [permutation][wiki-permutation] of these integers, corresponding to a sort of the input vector.

## Partial sort

Does your program need the entire input to be sorted?
In cases where only the first few or last few entries are interesting, it can be significantly quicker to do a [partial sort][wiki-partial-sort].

Julia provides the [`partialsort()`][ref-partialsort] and [`partialsort!()`][ref-partialsort!] functions, which guarantee that the specified entry or range of entries is correct, but provides no guarantees about the remainder of the input.

The second argument can be either an integer or a range, representing the index/indices of the sorted input:

```julia-repl
julia> vsq = [3, 2, 4, 1].^2  # would be [1, 4, 9, 16] after a full sort
4-element Vector{Int64}:
  9
  4
 16
  1

julia> partialsort(vsq, 4)
16

julia> partialsort(vsq, 2:3)
2-element view(::Vector{Int64}, 2:3) with eltype Int64:
 4
 9
```

## Sorting algorithms

Sorting `[3, 2, 4, 1]` is an easy challenge, either for a human or a computer.

If the input is _much_ larger, what is the best way to sort it?

This forces us to define "best"!

- Quickest average time?
- Best-case or worst-case time? Or an intermediate cutoff, such as 90th percentile time?
- Minimum memory usage?
- An approximate or partial sort, that is "good enough" for the current application?

Also, what is the input?
It may be essentially random, but special cases include arrays that are already sorted, or sorted in reverse order, or with lots of repeated entries.
Different algorithms will perform very differently in these situations.

Designing new and better sorting algorithms is both intellectually fascinating (_to a certain type of personality_) and commercially valuable: _a potent combination!_

Accordingly, there is a vast literature on this subject, which is still growing steadily.

Julia tries to choose a reasonable default algorithm in most cases, though programmers can [specify a preference][ref-algorithms] if necessary.

The next toy example is ridiculous, but illustrates the syntax:

```julia-repl
julia> v
4-element Vector{Int64}:
 3
 2
 4
 1

julia> sort(v, alg=InsertionSort)
4-element Vector{Int64}:
 1
 2
 3
 4
```

~~~~exercism/advanced
Anyone wanting full technical detail on sorting might like to consult [Knuth][wiki-knuth].

Chapter 5 of the 2nd Edition discusses sorting, as it was understood up to publication in 1998.

This chapter covers 391 dense and intellectually challenging pages, so the Exercism maintainers are regrettably unable to offer support to any students who struggle with it.

[wiki-knuth]: https://en.wikipedia.org/wiki/The_Art_of_Computer_Programming
~~~~


[ref-sorting]: https://docs.julialang.org/en/v1/base/sort/
[ref-sort]: https://docs.julialang.org/en/v1/base/sort/#Base.sort
[ref-sort!]: https://docs.julialang.org/en/v1/base/sort/#Base.sort!
[ref-abs]: https://docs.julialang.org/en/v1/base/math/#Base.abs
[ref-uppercase]: https://docs.julialang.org/en/v1/base/strings/#Base.Unicode.uppercase
[ref-algorithms]: https://docs.julialang.org/en/v1/base/sort/#Sorting-Algorithms
[wiki-permutation]: https://en.wikipedia.org/wiki/Permutation
[wiki-pure-func]: https://en.wikipedia.org/wiki/Pure_function
[ref-mutating-func]: https://docs.julialang.org/en/v1/manual/style-guide/#bang-convention
[concept-mda]: https://exercism.org/tracks/julia/concepts/multi-dimensional-arrays
[concept-range]: https://exercism.org/tracks/julia/concepts/ranges
[concept-multiple-dispatch]: https://exercism.org/tracks/julia/concepts/multiple-dispatch
[concept-composite-types]: https://exercism.org/tracks/julia/concepts/composite-types
[ref-sortperm]: https://docs.julialang.org/en/v1/base/sort/#Base.sortperm
[wiki-partial-sort]: https://en.wikipedia.org/wiki/Partial_sorting
[ref-partialsort]: https://docs.julialang.org/en/v1/base/sort/#Base.Sort.partialsort
[ref-partialsort!]: https://docs.julialang.org/en/v1/base/sort/#Base.Sort.partialsort!
