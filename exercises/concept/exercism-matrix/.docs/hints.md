# Hints

The introduction contains most of what is needed for this exercise.

## 1. Define the Exercism logo `Matrix`

- Get creative! However, you can also simply copy and paste from the instructions.

## 2. Define functions that make the logo frown

- Remember that functions ending in `!` mutate the input (modify in-place), while others do not.
- `frown!` can be done via assignment of specific elements, or (less efficiently) by swapping two rows.
- `frown` is going to be very similar to `frown!`, just returning a copy of the input matrix.

## 3. Put together a stickerwall

- Use your `frown()` function.
- The `vcat()` and `hcat()` functions, or their equivalents, are your friends here.
- The `ones()` and `zeros()` functions can also be quite useful.

## 4. Change dots to column pixel counts

- Broadcasting is a great way to do this concisely.
- To broadcast, you'll need a vector with the column dot counts.
- To get a vector with column dot count, you can apply a function to the `Matrix`.

## 5. Render a dot matrix

- Using `eachrow()` to loop may work well here.
- The function `join()` can also help.
