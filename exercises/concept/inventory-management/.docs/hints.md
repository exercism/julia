# Hints

**Remember**: The tests in this exercise are mutation agnostic, but the function names indicate they should be non-mutating.
If you would like to use functions from the introduction while not mutating the input, the function `copy()` will be helpful.

## 1. Create an inventory based on a vector

- It may help to look at Task 2 before starting this.

## 2. Add items from a vector to an existing dictionary

- The simplest approach is to loop over the input vector one item at a time.
- The [`haskey(dict, key)`][haskey] function will be useful.

## 3. Decrement items from the inventory

- The code is quite similar to Task 2, with a sign change.
- Remember not to let the item count fall below zero.
- `if...else` logic works, but the [`max()`][max] function allows concise and idiomatic code.

## 4. Remove an entry entirely from the inventory

- Julia has a function to do exactly this: read the Introduction.

## 5. Return the entire content of the inventory

- Remember to remove items with zero count.
- Beginners may find it easiest to loop over the items and [`push!()`][push] if appropriate.
- A Python-style list comprehension is much more concise, and adding an `if` clause at the end is permitted.
- Though requiring knowledge of later Concepts, students familiar with functional programming may want to investigate the [`filter()`][filter] function.
- A sorted list is required, and [`sort()`][sort] defaults to sorting by the first part of a pair.

[max]: https://docs.julialang.org/en/v1/base/math/#Base.max
[filter]: https://docs.julialang.org/en/v1/base/collections/#Base.filter
[haskey]: https://docs.julialang.org/en/v1/base/collections/#Base.haskey
[push]: https://docs.julialang.org/en/v1/base/collections/#Base.push!
[sort]: https://docs.julialang.org/en/v1/base/sort/#Base.sort
