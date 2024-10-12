# About

A [`Set`][set] is a collection of items with the following properties:

- Unordered.
- Entries are unique, so attempts to add duplicates are silently ignored.
- Supports many of the operations common with mathematical sets.

Create them with the `Set()` constructor, using any iterator as the parameter.

```julia-repl
julia> s1 = Set(1:4)
Set{Int64} with 4 elements:
  4
  2
  3
  1
```

Add new elements with `push!()` (the same as with arrays), and remove them with `delete!()`.

```julia-repl
julia> push!(s1, 5)
Set{Int64} with 5 elements:
  5
  4
  2
  3
  1

# Duplicates are ignored
julia> push!(s1, 3)
Set{Int64} with 5 elements:
  5
  4
  2
  3
  1

julia> delete!(s1, 5)
Set{Int64} with 4 elements:
  4
  2
  3
  1

julia> length(s1)  # length counts entries, despite the non-sequential type
4
```

## Set operations

As with several other collection types, check membership with the `in` or `∈` operator (use `\in` then tab for the symbol).

```julia-repl
julia> 3 ∈ s1
true
```

The following operations on pairs of Sets are supported (shortcuts to the operator symbol are shown in parentheses).

- `union(A, B)` or `A ∪ B` (`\cup`): all entries in A or B or both.
- `intersect(A, B)` or `A ∩ B` (`\cap`): all entries common to both A _and_ B.
- `setdiff(A, B)` (no symbol): entries in A but not in B.
- `symdiff(A, B)` (no symbol): entries in either A or B but not both.
- `issubset(A, B)` or `A ⊆ B` (`\subseteq`) or `B ⊇ A` (`\supseteq`): `true` if all entries in A are also in B.
- `issetequal(A, B)` (no symbol): `true` if A and B contain exactly the same entries.
- `isdisjoint(A, B)` (no symbol): `true` if A and B contain no entries in common (so intersect is empty).

```julia-repl
s1 = Set(1:4)
s2 = Set(3:6)

julia> s1 ∪ s2  # union
Set{Int64} with 6 elements:
  5
  4
  6
  2
  3
  1

julia> s1 ∩ s2  # intersect
Set{Int64} with 2 elements:
  4
  3
  
julia> setdiff(s1, s2)
Set{Int64} with 2 elements:
  2
  1

julia> symdiff(s1, s2)
Set{Int64} with 4 elements:
  5
  6
  2
  1
  
julia> s1 ⊇ s2  # issubset
false
```

There are also mutating versions of many of these, with `!` added to the function name.
See the [manual][set] for a full list of functions.


[set]: https://docs.julialang.org/en/v1/base/collections/#Set-Like-Collections
[union]: https://docs.julialang.org/en/v1/base/collections/#Base.union
[intersect]: https://docs.julialang.org/en/v1/base/collections/#Base.intersect
[setdiff]: https://docs.julialang.org/en/v1/base/collections/#Base.setdiff
[symdiff]: https://docs.julialang.org/en/v1/base/collections/#Base.symdiff
[issubset]: https://docs.julialang.org/en/v1/base/collections/#Base.issubset
[issetequal]: https://docs.julialang.org/en/v1/base/collections/#Base.issetequal
[isdisjoint]: https://docs.julialang.org/en/v1/base/collections/#Base.isdisjoint
