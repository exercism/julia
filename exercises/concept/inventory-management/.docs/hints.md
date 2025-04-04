# Hints

## 1. Create an inventory based on a vector

- It may help to look at Task 2 before starting this.

## 2. Add items from a vector to an existing dictionary

- The simplest approach is to loop over the input vector one item at a time.
- The `haskey(dict, key)` function will be useful.

## 3. Decrement items from the inventory

- The code is quite similar to Task 2, with a sign change.
- Remember not to let the item count fall below zero.
- `if...else` logic works, but the `max()` function allows concise and idiomatic code.

## 4. Remove an entry entirely from the inventory

Julia has a function to do exactly this: read the Introduction.

## 5. Return the entire content of the inventory

- Remember to remove items with zero count.
- Beginners may find it easiest to loop over the items and `push!()` if appropriate.
- A Python-style list comprehension is much more concise, and adding an `if` clause at the end is permitted.
- A sorted list is required, and `sort()` defaults to sorting by the first part of a pair.
