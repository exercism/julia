# Hints

The introduction contains most of what is needed for this exercise.
Task 5 (rendering) can be done earlier to help with visualization, but be careful to take into account different possible dot values.

## 1. Define the Exercism logo `Matrix`

- Get creative! However, you can also simply copy and paste from the instructions.

## 2. Define functions that make the logo frown

- Remember that functions ending in `!` mutate the input (modify in-place), while others do not.
- `frown!` can be done via assignment of specific elements, or (less efficiently) by swapping two rows.
- `frown` is going to be very similar to `frown!`, just returning a copy of the input matrix.

## 3. Put together a stickerwall

- Use your `frown()` function.
- The `vcat()` and `hcat()` functions, or their equivalents, are your friends here.
- Notice there is a row of `1`s (i.e. `X`s) separating the top half from the bottom half.
- The function `ones()` can be used if desired, but be careful with its shape.

## 4. Change dots to column pixel counts

- Broadcasting is a great way to do this concisely.
- To broadcast, you'll need a *row* vector with the column dot counts.
- To get a vector with column dot counts, you can apply a function to the `Matrix` with the `dims` specified.

## 5. Render a dot matrix

- The dots (e.g. `1`, `2`, etc.) and `0`s need to be changed to `"X"` and `" "`, respectively.
- Using `eachrow()` for an inner loop may be useful here but is not necessary.
- The function `join()` can also help to make things more concise and could even be broadcast.
