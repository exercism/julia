# Hints

## 1. Retrieve a card from a deck

- `Vector` indices start at `1`.
- You can retrieve the `n`th value in a vector `v` with `v[n]`.

## 2. Exchange a card in the deck

- `Vector`s are mutable, you can change their contents at any time.
- The method takes a [Pair](https://docs.julialang.org/en/v1/base/collections/#Base.Pair) as an argument.
- You can access the fields of a pair `p` using `p.first` and `p.second`.

## 3. Insert a card at the of top the deck

- There is a method [`push!`](https://docs.julialang.org/en/v1/base/collections/#Base.push!) in Base to add a new value to the end of a collection.

## 4. Remove a card from the deck

- There is a method [`deleteat!`](https://docs.julialang.org/en/v1/base/collections/#Base.deleteat!) in Base to delete an element from a `Vector` at a given index.

## 5. Remove the top card from the deck

- There is a method [`pop!`](https://docs.julialang.org/en/v1/base/collections/#Base.pop!) in Base to remove an element at the end of a collection.

## 6. Insert a card at the bottom of the deck

- There is a method [`pushfirst!`](https://docs.julialang.org/en/v1/base/collections/#Base.pushfirst!) in Base to insert a new value to start of a collection.

## 7. Remove a card from the bottom of the deck

- There is a method [`popfirst!`](https://docs.julialang.org/en/v1/base/collections/#Base.popfirst!) in Base to remove an element at the start of a collection.

## 8. Check size of the deck

- There is a method [`length`](https://docs.julialang.org/en/v1/base/collections/#Base.length) in Base to retrieve the length of a collection.
