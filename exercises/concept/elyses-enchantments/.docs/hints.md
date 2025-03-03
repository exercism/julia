# Hints

## 1. Retrieve a card from a stack

- `Vector` indices start at `1`.
- You can retrieve the `n`th value in a vector `v` with `v[n]`.

## 2. Exchange a card in the stack

- `Vector`s are mutable, you can change their contents at any time by assigning a new value.

## 3. Insert a card at the of top of the stack

- There is a method [`push!`][push] in Base to add a new value to the end of a collection.

## 4. Remove a card from the stack

- There is a method [`deleteat!`][deleteat] in Base to delete an element from a `Vector` at a given index.

## 5. Remove the top card from the stack

- There is a method [`pop!`][pop] in Base to remove an element at the end of a collection.

## 6. Insert a card at the bottom of the stack

- There is a method [`pushfirst!`][pushfirst] in Base to insert a new value to start of a collection.

## 7. Remove a card from the bottom of the stack

- There is a method [`popfirst!`][popfirst] in Base to remove an element at the start of a collection.

## 8. Check the size of the stack

- There is a method [`length`][length] in Base to retrieve the length of a collection.

[push]: https://docs.julialang.org/en/v1/base/collections/#Base.push!
[pop]: https://docs.julialang.org/en/v1/base/collections/#Base.pop!
[pushfirst]: https://docs.julialang.org/en/v1/base/collections/#Base.pushfirst!
[popfirst]: https://docs.julialang.org/en/v1/base/collections/#Base.popfirst!
[insert]: https://docs.julialang.org/en/v1/base/collections/#Base.insert!
[deleteat]: https://docs.julialang.org/en/v1/base/collections/#Base.deleteat!
[length]: https://docs.julialang.org/en/v1/base/collections/#Base.length
