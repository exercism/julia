# Hints

## 1. Define a Coord type.

- `Coord` is a `struct`.
- The fields are `x` and `y`.
- Both have type `UInt16`

## 2. Define a Plot type.

- `Plot` is a keyword `struct`.
- The fields are `bottom_left` and `top_right`.
- Both have type `Coord`.

## 3. Check whether your claim has already been filed.

- Is the claim already an element in the `register`?
- Refresh your knowledge of [`Sets`][sets] if necessary.

## 4. Speculators can stake their claim by specifying a plot identified by its corner coordinates.

- If the same claim has already been filed, return `false` to indicate your claim failed.
- If allowed, add your claim to the register. The [`push!()][push] function may be useful.
- Because `stake_claim!()` is a mutating function, changes in the `register` will be visible to the caller.
- Chaining dot notation is allowed, such as `claim.bottom_left.x`.
- Return `true` to indicate success.

## 5. Find the length of a plot's longer side.

- Remember the orientation of these rectangular plots. You can infer the `top_left` and `bottom_right` coordinates.
- Calculating the lengths of the sides is simple arithmetic.
- Be aware of the difference between [`max()`][max] and [`maximum()`][maximum]. `max` takes an arbitrary number of arguments to compare, `maximum` takes a single iterable.

```julia-repl
julia> max(1, 2, 3)
3

julia> v = [1, 2, 3];
julia> maximum(v)
3
```

## 6. Find the plot claimed that has the longest side, for research purposes.

- The register is a Set, unordered but iterable.
  - It may be convenient to convert the register to something ordered, for example with `collect()`.
  - You already wrote a function to calculate the longest side of a plot, and could apply this to the whole collection.
- See Task 5 for a note on `max` versus `maximum`.
- Find one or more plots with the maximum length.
- Return the results as a `Set{Plot}`.


[push]: https://docs.julialang.org/en/v1/base/collections/#Base.push!
[max]: https://docs.julialang.org/en/v1/base/math/#Base.max
[maximum]: https://docs.julialang.org/en/v1/base/collections/#Base.maximum
[sets]: https://exercism.org/tracks/julia/concepts/sets
