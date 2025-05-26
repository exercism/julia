# Hints

## 1. Define the TreasureChest type

- The Introduction contains everything you need for this.

## 2. Define the get_treasure() function

- A [ternary operator][ternary] is sufficient.

## 3. Define the multiply_treasure function

- The return value will be a `TreasureChest{Vector{T}}`, where `T` is the type of the treasure in the supplied chest.
- To create a vector with repeated elements, there are two functions to choose from:
  - [`fill(value, multiplier)`][fill] takes a scalar value and repeats it.
  - [`repeat([value,], multiplier)`][repeat] repeats the given vector.
  
  [ternary]: https://docs.julialang.org/en/v1/manual/control-flow/#man-conditional-evaluation
  [fill]: https://docs.julialang.org/en/v1/base/arrays/#Base.fill
  [repeat]: https://docs.julialang.org/en/v1/base/strings/#Base.repeat-Tuple%7BAbstractString,%20Integer%7D
