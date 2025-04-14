# Hints

## 1. Extract coordinates

- We are trying to pull one element out of a tuple.
- Indexing is one possibility.
- Multiple assignment is an alternative approach.

## 2. Format coordinates

- Remember the [`Tuple()`][Tuple] constructor.

## 3. Match coordinates

- You already have a function to convert Azara's coordinate into Rui's format.
- Testing for equality is one possibility.
- Alternatively, test if the coordinate is in Rui's record (∈).

## 4. Combine matched records

- Do the records match? You already know how to test this.
- If matching, the desired elements need to be combined in a different order in the return value.
- Not every element in the input tuple is output.
- Unpacking is your friend. Giving elements meaningful names is more readable and easier to debug than using indexing.

[Tuple]: https://docs.julialang.org/en/v1/base/base/#Core.Tuple
