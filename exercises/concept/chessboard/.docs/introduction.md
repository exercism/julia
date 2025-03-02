# Introduction

Suppose you want all the non-negative integers up to 1000.
It would be ridiculous if you had to type these into an array.

For this we have the `range` type:

```julia-repl
julia> 0:1000
0:1000

julia> typeof(0:1000)
UnitRange{Int64}
```

Ranges are very common: not just to save you typing, but also as return types from functions.

Note that ranges are _not_ vectors.
They are just a set of instructions to generate a sequence ("lazy" evaluation, or an "iterator").

If you need an vector, use the `collect()` function for conversion:

```julia-repl
julia> collect(0:5)
6-element Vector{Int64}:
 0
 1
 2
 3
 4
 5
```

The step size can be specified, in this case 0.3:

```julia-repl
julia>  collect(1.0:0.3:2.0)
4-element Vector{Float64}:
 1.0
 1.3
 1.6
 1.9
```

So the syntax is `start:stepsize:stop`.
Both end limits are _inclusive_, as seen in the integer example.
If the step size does not divide exactly into `stop - start`, the last element will avoid exceeding `stop`.

## Letter ranges

Non-numeric sequences can also be used in ranges.
The simplest example is ASCII letters:

```julia-repl
julia> 'a':'d'
'a':1:'d'

julia> typeof('a':'d')
StepRange{Char, Int64}

julia> collect('a':'d')
4-element Vector{Char}:
 'a': ASCII/Unicode U+0061 (category Ll: Letter, lowercase)
 'b': ASCII/Unicode U+0062 (category Ll: Letter, lowercase)
 'c': ASCII/Unicode U+0063 (category Ll: Letter, lowercase)
 'd': ASCII/Unicode U+0064 (category Ll: Letter, lowercase)
```

The `Char` type will be covered in more detail in another Concept.
For now, just treat these as single characters in single-quotes.

## Functions and operators for ranges

Check the limits of a range with `first()` and `last()`.

```julia
 r = 1:10  # => 1:10
 first(r)  # => 1
 last(r)   # => 10
```

## More on vector indexing

Integer ranges and vectors can be used in vector indexing:

```julia
nums = collect(10.0:50.0)
nums[3:2:7]  # gives [12.0, 14.0, 16.0]
nums[ [3, 5, 7] ] # also gives [12.0, 14.0, 16.0]
```
