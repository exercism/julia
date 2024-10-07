A `Pair` is a data structure that contains exactly two elements accessible through the fields `first` and `second` or the indices `1` and `2`.

They can be constructed using `x => y` or `Pair(x, y)`:

```julia-repl
julia> p = 3 => true
3 => true

julia> p == Pair(3, true)
true

julia> p.first
3

julia> p.second
true
```

The elements of a `Pair` may be of different type:

```julia-repl
julia> typeof(p)
Pair{Int64,Bool}
```

`Pair`s have two common uses in Julia: dictionaries and replacements.

## Dictionaries

Dictionaries can be constructed from a collection of pairs:

```julia-repl
julia> Dict(1 => 4, 3 => -2, 5 => 10)
Dict{Int64,Int64} with 3 entries:
  3 => -2
  5 => 10
  1 => 4
```

<!-- TODO: Add widget to dictionary exercise -->

## Replacements

Many replacement methods take a `Pair` as an argument to make it clear which element is being replaced.
This allows syntax like

```julia-repl
julia> replace!([1, 3, 4, 1], 4 => 0)
4-element Array{Int64,1}:
 1
 3
 0
 1
```

where each `4` in the collection is replaced by `0`, instead of the less clear syntax

```julia
replace!([1, 3, 4, 1], 4, 0) # this method doesn't exist
```
