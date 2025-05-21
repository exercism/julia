# Hints

## 1. Define the TreasureChest type

- The Introduction contains everything you need for this.

## 2. Define the get_treasure() function

- This task just uses simple logic.
- A ternary operator is sufficient.

## 3. Define the multiply_treasure function

- The return value will be a `TreasureChest{Vector{T}}`, where `T` is the type of the treasure in the supplied chest.
- To create a vector with repeated elements, there are two functions to choose from:
  - `fill(value, multiplier)` takes a scalar value and repeats it.
  - `repeat([value,], multiplier)` repeats the given vector.
  