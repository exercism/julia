# Hints

## General

Remember, this is an [MVP][mvp].
That means you don't need to get too fancy with error handling or different "edge case" scenarios.
It's OK to be simple and direct with the functions you are writing.


## 1. Add Item(s) to the Users Shopping Cart

- You will need to iterate through each item in `items`.
- You can avoid a `KeyError` when a key is missing by using a `Dict` method, mentioned in the introduction, that takes a _default value_ as one of its arguments.
- It is also possible to accomplish the same thing manually in a `loop` by using `haskey()`, but the `Dict` method can be cleaner.
- Remember the bang (`!`) in the function name means we are mutating the original `Dict`.

## 2. Update Recipe "Ideas" Section

- Don't overthink this one! This can be solved in **one** `Dict` [method call][merge].
- Remember the bang (`!`) in the function name means we are mutating the original `Dict`.

## 3. Send User Shopping Cart to Store for Fulfillment

- `Looping` through the [keys][keys] of the cart might be the most direct way of accessing things here.
- Remember that you can get the `value` of a given key by using `<dict name>[<key_name>]` syntax.
- Remember we are returning an `Array`, since `Dict`s don't retain insertion order.

## 4. Update the Store Inventory to Reflect what a User Has Ordered.

- The update can be solved with a `Dict` [higer order function][mergewith].
- The bang (`!`) refers to mutating `inventory`.
- The returned `Dict` should be new.

## 5. Reorder Out-of-Stock Items.

- This is similar to the first task.
- If you used the method hinted at for the first task, you may want to use a [slightly different version][get] here.
- `outofstock` will be mutated, while `stock` may or may not be mutated (depending on promotional items).

[dicts-docs]: https://docs.julialang.org/en/v1/base/collections/#Dictionaries
[keys]: https://docs.julialang.org/en/v1/base/collections/#Base.keys
[merge]: https://docs.julialang.org/en/v1/base/collections/#Base.merge!
[mvp]: https://en.wikipedia.org/wiki/Minimum_viable_product
[mergewith]: https://docs.julialang.org/en/v1/base/collections/#Base.mergewith!
[get]: https://docs.julialang.org/en/v1/base/collections/#Base.get!
