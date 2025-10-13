# Hints

## 1. Classify customers

- The `any()` or `all()` functions can be helpful here.
- A separate function can be defined for use in these, or an anonymous function can be used directly.

## 2. Separate out emphatic customers

- You need to filter the dictionary.
- A dictionary, by default, iterates a key/value `Pair` which can be access by fields (first/second) or index (1/2).
- Make use of your `all_15()` function.

## 3. Change ratings to binary

- You need a mapping of `1` to `0` and `5` to `1`.
- Make sure that the output array shape is the same as the input array shape.

## 4. Make ratings into a matrix

- This can be done with `mapreduce()`.
- Make use of your `tobinary()` function for (part of?) the mapping.
- A matrix can be had by reducing a vector of vectors with `hcat()` or `vcat()`, depending on column or row vector input, respectively.
- Watch the your output. Is each rating vector a row in the matrix? The `transpose()` function may be helpful somewhere.
