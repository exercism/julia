# Hints

## General

- `Vector` indices start at `1`.
- The decks of cards do not contain any duplicate cards.

## 1. Determine if a card is present

- There is a method [`in`/`∈`](https://docs.julialang.org/en/v1/base/collections/#Base.in) in Base to determine if a collection contains a value.

## 2. Find the position of a card

- There is a method [`findfirst`](https://docs.julialang.org/en/v1/base/arrays/#Base.findfirst-Tuple{Function,%20Any}) in Base to find the position of the first element of a collection that matches a given predicate.
- `==(x)` can be used as predicate to find elements that equal `x` in methods that take predicate functions.

## 3. Determine if each card is even

- There is a method [`all`](https://docs.julialang.org/en/v1/base/collections/#Base.all-Tuple{AbstractArray,%20Any}) in Base that returns `true` if all elements in a collection satisfy a given predicate.
- [`iseven`](https://docs.julialang.org/en/v1/base/numbers/#Base.iseven) is a predicate function.

## 4. Check if the deck contains an odd-value card

- There is a method [`any`](https://docs.julialang.org/en/v1/base/collections/#Base.any-Tuple{AbstractArray,%20Any}) in Base that returns `true` if any elements in a collection satisfy a given predicate.
- [`isodd`](https://docs.julialang.org/en/v1/base/numbers/#Base.isodd) is a predicate function.

## 5. Determine the position of the first card that is even

- There is a method [`findfirst`](https://docs.julialang.org/en/v1/base/arrays/#Base.findfirst-Tuple{Function,%20Any}) in Base to find the position of the first element of a collection that matches a given predicate.
- [`iseven`](https://docs.julialang.org/en/v1/base/numbers/#Base.iseven) is a predicate function.

## 6. Get the first odd card from the deck

- You can retrieve the `n`th value in a vector `v` with `v[n]`.
- There is a method [`findfirst`](https://docs.julialang.org/en/v1/base/arrays/#Base.findfirst-Tuple{Function,%20Any}) in Base to find the position of the first element of a collection that matches a given predicate.
- If no elements of the given collection match the predicate given to `findfirst`, `findfirst` returns `nothing`.
- Review how `nothing` works in Julia: [concept:julia/nothingness](../../../../concepts/nothingness/about.md)
- Review how conditionals work in Julia: [concept:julia/conditionals](../../../../concepts/conditionals/about.md)
