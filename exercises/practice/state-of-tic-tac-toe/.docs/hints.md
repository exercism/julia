# Hints

## General

- There are many ways to solve this exercise, and planning your strategy is a key part of the challenge.
- In line with other tracks, input is a `Vector{String}`. 
- Because Julia has a native [`Matrix` type][matrix] in the base language, you may find it easier to convert the board to some sort of `Matrix` (`String`, `Char`, `Int`...).
- Beware of edge cases, which raise the exercise difficulty from Easy to Medium.
  - It is possible to make a move that wins on 2 dimensions simultaneously.
  - Which combinations of dimensions are possible and valid?

## For the mathematically-inclined

- The [`LinearAlgebra` module][linearalgebra] is available in the test runner.
- It may contain useful functions, such as [`diag()`][diag].
- This is just an option for those so inclined. Use of linear algebra is not at all essential.


[linearalgebra]: https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/
[matrix]: https://docs.julialang.org/en/v1/base/arrays/#Base.Matrix
[diag]: https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#LinearAlgebra.diag
