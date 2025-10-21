# Introduction

The [Pairs and Dicts][pairs-dicts] Concept discussed the basics of Julia's dictionary type.

Because `Dict`s are an important and often-used collection type, there are also many functions to manipulate them.

## Getting entries

The simplest way to retrieve an entry is by key (as in many languages).
However, asking for a non-existent key is a `KeyError`.

```julia-repl
julia> d = Dict(i => ('a':'c')[i] for i in 1:3)
Dict{Int64, Char} with 3 entries:
  2 => 'b'
  3 => 'c'
  1 => 'a'

julia> d[2]
'b': ASCII/Unicode U+0062 (category Ll: Letter, lowercase)

# missing key
julia> d[4]
ERROR: KeyError: key 4 not found
```

We could test for the key before trying to retrieve it (with something like `haskey(d, 4)` or `4 ∈ keys(d)`), but it can be useful to just get a default value for missing keys.

For this, we have the `get()` function and its mutating variant `get!()`.
These differ in whether the "missing" key is added to the `Dict`.

```julia-repl
julia> get(d, 4, '!')
'!': ASCII/Unicode U+0021 (category Po: Punctuation, other)

# get() leaves Dict unchanged
julia> d
Dict{Int64, Char} with 3 entries:
  2 => 'b'
  3 => 'c'
  1 => 'a'

julia> get!(d, 4, '!')
'!': ASCII/Unicode U+0021 (category Po: Punctuation, other)

# get!() adds new key to Dict
julia> d
Dict{Int64, Char} with 4 entries:
  4 => '!'
  2 => 'b'
  3 => 'c'
  1 => 'a'
```

We saw in the earlier Concept that `delete!()` will remove an entry by key.
This can be combined with retrieving the value, by using the `pop!()` function.

```julia-repl
julia> d
Dict{Int64, Char} with 4 entries:
  4 => '!'
  2 => 'b'
  3 => 'c'
  1 => 'a'

# popped value is returned
julia> pop!(d, 3)
'c': ASCII/Unicode U+0063 (category Ll: Letter, lowercase)

# Dict is shrunk
julia> d
Dict{Int64, Char} with 3 entries:
  4 => '!'
  2 => 'b'
  1 => 'a'
```

## Iteration

Iterating over a `Dict` defaults to yielding `key => value` pairs.
The components are accessible with the usual `.first` and `.second` nomenclature.

```julia-repl
# d is from the previous example
julia> [(kv.first, kv.second) for kv in d]
3-element Vector{Tuple{Int64, Char}}:
 (4, '!')
 (2, 'b')
 (1, 'a')
```

Often, we want to use just the keys or just the values, which is easy.

```juliajulia> [k for k in keys(d)]
julia> [k for k in keys(d)]
3-element Vector{Int64}:
 4
 2
 1

julia> [v for v in values(d)]
3-element Vector{Char}:
 '!': ASCII/Unicode U+0021 (category Po: Punctuation, other)
 'b': ASCII/Unicode U+0062 (category Ll: Letter, lowercase)
 'a': ASCII/Unicode U+0061 (category Ll: Letter, lowercase)
```

## Merging

Combining two `Dict`s can be useful, but we need to be clear about what we intend to do with keys that are present in more than one input.

The `merge()` and `merge!()` functions will combine an arbitrary number of supplied `Dict`s in a left-to right fashion.

Existing keys have their values simply overwritten, so the right-most `Dict` "wins".

```julia-repl
julia> d3 = Dict("color" => "red", "shape" => "circle")
Dict{String, String} with 2 entries:
  "shape" => "circle"
  "color" => "red"

julia> d4 = Dict("color" => "blue", "coords" => (3, 2))
Dict{String, Any} with 2 entries:
  "color"  => "blue"
  "coords" => (3, 2)

# color from d3 is lost
julia> merge(d3, d4)
Dict{String, Any} with 3 entries:
  "shape"  => "circle"
  "color"  => "blue"
  "coords" => (3, 2)
```

The `mergewith()` and `mergewith!()` functions lets us supply a function as the first argument, to define how repeated keys should be merged.
Addition is a simple example.

```julia-repl
julia> d5 = Dict("color" => "red", "area" => 3)
Dict{String, Any} with 2 entries:
  "area"  => 3
  "color" => "red"

julia> d6 = Dict("shape" => "circle", "area" => 5)
Dict{String, Any} with 2 entries:
  "shape" => "circle"
  "area"  => 5

# area values are added, not overwritten
julia> mergewith(+, d5, d6)
Dict{String, Any} with 3 entries:
  "shape" => "circle"
  "area"  => 8
  "color" => "red"
```

Concatenating two vectors is another popular operation when merging.
For this, Julia uses the `vcat()` function, for reasons explained in the [`Multi Dimensional Arrays`][multidim] Concept.

```julia-repl
julia> d7 = Dict("vals" => [1, 2, 3])
Dict{String, Vector{Int64}} with 1 entry:
  "vals" => [1, 2, 3]

julia> d8 = Dict("vals" => [4, 5])
Dict{String, Vector{Int64}} with 1 entry:
  "vals" => [4, 5]

julia> mergewith(vcat, d7, d8)
Dict{String, Vector{Int64}} with 1 entry:
  "vals" => [1, 2, 3, 4, 5]
```

For multiple [`Set`s][sets], the corresponding merge function is `union`.

Note that the `mergewith` functions are a good example of [Higher Order Functions][hof] in action.


[pairs-dicts]: https://exercism.org/tracks/julia/concepts/pairs-and-dicts
[multidim]: https://exercism.org/tracks/julia/concepts/multi-dimensional-arrays
[sets]: https://exercism.org/tracks/julia/concepts/sets
[hof]: https://exercism.org/tracks/julia/concepts/higher-order-functions
