# Hints

## 1. Determine if a card is present

- `Vector` indices start at `1`.
- There is a method [`in`/`∈`](https://docs.julialang.org/en/v1/base/collections/#Base.in) in Base to determine if a collection contains a value.

## 2. Find the position of a card

- The stacks of cards do not contain any duplicate cards.
- There is a method [`findfirst`](https://docs.julialang.org/en/v1/base/arrays/#Base.findfirst-Tuple{Function,%20Any}) in Base to find the position of the first element of a collection that matches a given predicate.
- `==(x)` can be used as predicate to find elements that equal `x` in methods that take predicate functions.

## 3. Determine if each card is even

- The stacks of cards do not contain any duplicate cards.
- There is a method [`all`](https://docs.julialang.org/en/v1/base/collections/#Base.all-Tuple{AbstractArray,%20Any}) in Base to find the position of the first element of a collection that matches a given predicate.
- [`iseven`](https://docs.julialang.org/en/v1/base/numbers/#Base.iseven) can be used as predicate to find elements that equal `x` in methods that take predicate functions.

## 4. Check if the stack contains an odd-value card

- The stacks of cards do not contain any duplicate cards.
- There is a method [`any`](https://docs.julialang.org/en/v1/base/collections/#Base.any-Tuple{AbstractArray,%20Any}) in Base to find the position of the first element of a collection that matches a given predicate.
- [`isodd`](https://docs.julialang.org/en/v1/base/numbers/#Base.isodd) can be used as predicate to find elements that equal `x` in methods that take predicate functions.

## 5. Determine the position of the first card that is even

- `Vector` indices start at `1`.
- The stacks of cards do not contain any duplicate cards.
- There is a method [`findfirst`](https://docs.julialang.org/en/v1/base/arrays/#Base.findfirst-Tuple{Function,%20Any}) in Base to find the position of the first element of a collection that matches a given predicate.
- [`iseven`](https://docs.julialang.org/en/v1/base/numbers/#Base.iseven) can be used as predicate to find elements that equal `x` in methods that take predicate functions.

## 6. Get the first odd card from the stack

- `Vector` indices start at `1`.
- You can retrieve the `n`th value in a vector `v` with `v[n]`.
- There is a method [`findfirst`](https://docs.julialang.org/en/v1/base/arrays/#Base.findfirst-Tuple{Function,%20Any}) in Base to find the position of the first element of a collection that matches a given predicate.
- If no elements of the given collection match the predicate given to `findfirst`, `findfirst` returns `nothing`.
- Review how `nothing` works in Julia: [concept:julia/nothingness](../../../../concepts/nothingness/about.md)
- Review how conditionals work in Julia: [concept:julia/conditionals](../../../../concepts/conditionals/about.md)
