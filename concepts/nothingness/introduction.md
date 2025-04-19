# Introduction

Many languages have a way such as `null` or `none` to indicate a non-existent value.
Because Julia is designed to handle large volumes of (often messy) data, it has multiple forms of nothingness.

The overall aim is to flag missing or suspect values as they are encountered, then continue without raising an exception.

## `nothing`

If a value really does not exist, it is represented by `nothing`. This is probably closest to what C (`NULL`) or Python (`None`) might do.

```julia-repl
julia> n = nothing

julia> isnothing(n)
true

julia> typeof(n)
Nothing
```

So `nothing` is a singleton value of type `Nothing`, and we can test for it.

One common use of `nothing` is as a return (non-)value for functions which are used only for their side effects (printing, network configuration, or whatever).

## `missing`

For situations where a value exists in theory but we don't know what it is, `missing` is used. For example, when counting vehicles traveling on a road, human observers might need a break or automatic sensors break down, but the traffic continues to flow.

Thus `missing` is a placeholder, warning humans that they need to make a decision about how to handle this gap in the data.

```julia-repl
julia> mv = [1, 2, missing]
3-element Vector{Union{Missing, Int64}}:
 1
 2
  missing

julia> typeof(mv)
Vector{Union{Missing, Int64}} (alias for Array{Union{Missing, Int64}, 1})

julia> ismissing.(mv)  # broadcast function, displays as 1 for true, 0 for false
3-element BitVector:
 0
 0
 1
```

Few other languages have this feature built in, but close analogues are `NA` in R or `NULL` in SQL.

Expressions usually return `missing` by default if `missing` values are present.
If you want these values to be ignored, use the `skipmissing()` function to make this explicit:

```julia-repl
julia> mv = [1, 2, missing]
3-element Vector{Union{Missing, Int64}}:
 1
 2
  missing

julia> sum(mv)  # missing in, missing out
missing

julia> skipmissing(mv)
skipmissing(Union{Missing, Int64}[1, 2, missing])

julia> collect(skipmissing(mv))
2-element Vector{Int64}:
 1
 2

julia> sum(skipmissing(mv))  # functions like sum() can work with iterators
3
```

Because `skipmissing` creates an iterator, wrap it in `collect()` if you need a vector.

Sometimes it is useful to replace `missing` values with some default.
The `@coalesce()` macro is useful for this, as it will return the first non-missing value (or `missing` if there is nothing else).

```julia-repl
julia> str = ["I", "exist", missing]
3-element Vector{Union{Missing, String}}:
 "I"
 "exist"
 missing

julia> [@coalesce(s, "-") for  s in str]
3-element Vector{String}:
 "I"
 "exist"
 "-"
```

## `NaN`

Short for "Not a Number", NaN flags a computation problem in situations where a number was expected.

```julia-repl
julia> v = [0, 1, -1]
3-element Vector{Int64}:
  0
  1
 -1

julia> v / 0
3-element Vector{Float64}:
 NaN
  Inf
 -Inf
 
julia> sum(v / 0)
NaN
```

Any sort of calculation on data including a NaN will give a `NaN` result.

There is currently no special function to remove `NaN` values, but the standard `filter()` function can do this quite simply.
Only values for which some given condition is `true` will be copied to the result array:

```julia-repl
julia> filter(!isnan, [1, 2, NaN])
2-element Vector{Float64}:
 1.0
 2.0
```
