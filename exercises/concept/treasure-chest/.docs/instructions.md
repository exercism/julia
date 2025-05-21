# Instructions

In this exercise you're going to write a generic (/ magical!) TreasureChest, to store some treasure.

## 1. Define the TreasureChest type

Define a `TreasureChest{T}` parametric type with two fields.

- A `password` field of type `String`, which will be used to store the password of the treasure chest.
- A `treasure` field of type `T`, which will be used to store the treasure.
This value is generic so that the treasure can be anything.

```julia-repl
julia> chest = TreasureChest{String}("password", "gold")
TreasureChest{String}("password", "gold")
```



## 2. Define the get_treasure() function

This function should take two arguments.

- A `String` (for trying a password)
- A `TreasureChest` type

This function should check the provided password attempt against the `password` in the `TreasureChest`.

- If the passwords match then return the treasure.
- If the passwords do not match then return `nothing`.

```julia-repl
julia> get_treasure("password", chest)
"gold"

julia> get_treasure("wrong", chest)
# no output

julia> isnothing(get_treasure("wrong", chest))
true
```

## 3. Define the multiply_treasure() function

This function should take two arguments.

- An integer multiplier `n`.
- A `TreasureChest{T}` type.

The function should return a new `TreasureChest{Vector{T}}`, with 
- The same password as the original
- The multiplied treasure as a `Vector{T}` of length `n`, and the original treasure repeated `n` times.

```julia-repl
julia> multiply_treasure(3, chest)
TreasureChest{Vector{String}}("password", ["gold", "gold", "gold"])
```
