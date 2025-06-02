# Hints

The first three tasks all call the same `print_name_badge()` function.
Implementation of this can be built up stepwise, adding logic for tasks 2 and 3 as you proceed.

## 1. Create a badge for an employee

- This is the default case, just assemble the 3 arguments into a suitable string.
- [String interpolatation][interpolation] is probably the easiest approach.

## 2. Create a badge for a new employee

- Now the iID is `missing,` so the target string format is different.
- [`ismissing()][ismissing] is useful here.
- Julia has a [ternary operator][ternary] with concise syntax.

## 3. Create a badge for the owner

- Now the department is `nothing`.
- There is an [`isnothing()`][isnothing] function.

## 4. Calculate the total salary of emplyees with no ID

- Are [any][any] IDs missing? If not, the return value is zero.
- To pull out entries with missing ID, it may help to start by [zipping][zip] the `ids` and `salaries` vectors.
- There are several ways to iterate over the resulting vector of tuples, without writing an explicit loop.
  - Pythonically, with a vector [comprehension][comprehension].
  - Functionally, with [`map()`][map] and an [anonymous function][anonymous].
  - Vectorially, with [broadcasting][broadcasting] of an [anonymous function][anonymous].
- At the end, there will be a [`sum()`][sum] over a modified salaries vector.
   - The salaries of employees with IDs can either be omitted or set to zero.

[interpolation]: https://exercism.org/tracks/julia/concepts/strings
[isnothing]: https://docs.julialang.org/en/v1/base/base/#Base.isnothing
[ismissing]: https://docs.julialang.org/en/v1/base/base/#Base.ismissing
[ternary]: https://docs.julialang.org/en/v1/base/base/#?:
[any]: https://docs.julialang.org/en/v1/base/collections/#Base.any-Tuple{AbstractArray,%20Any}
[comprehension]: https://docs.julialang.org/en/v1/manual/arrays/#man-comprehensions
[anonymous]: https://docs.julialang.org/en/v1/manual/functions/#man-anonymous-functions
[broadcasting]: https://exercism.org/tracks/julia/concepts/vector-operations
[sum]: https://docs.julialang.org/en/v1/base/collections/#Base.sum
[map]: https://docs.julialang.org/en/v1/base/collections/#Base.map
[zip]: https://docs.julialang.org/en/v1/base/iterators/#Base.Iterators.zip
