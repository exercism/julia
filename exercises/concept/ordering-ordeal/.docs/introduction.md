# Introduction

Julia, like most programming languages, provides a rich variety of collection types.

Some are inherently ordered (including `Vectors` and higher-dimensional `Arrays`), so we can access elements by position.
Other collections are unordered (`Sets`, `Dicts`), and elements must be accessed by key or value.

In the simplest case, suppose we have a `Vector` of `Ints`, and want to sort it in ascending order.

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
The `sort()` function has an obvious name, and apparently returns the sorted `Vector`.

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

This is good design in many contexts: we have a pure function whose behaviour is easy to reason about, even in parallel, distributed code.

On the other hand, suppose we had an array of a billion strings, and wanted to sort it.

The sorting is probably slow.
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

This can be efficient, it can be buggy and lead to unexpected side-effects, it can be confusing to other people using your code.
_Choose carefully!_

`sort!()` is a "mutating function", and by (_very strong_) convention, any function that mutates its inputs has a `!` appended to its name, as a warning to programmers.

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

Because `langs` is a Vector, each index is an integer in the range `1:length(langs)`.
Output from `sortperm()` is a permutation of these integers, corresponding to a sort of the input vector.
