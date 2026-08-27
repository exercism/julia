# Hints

## 1. Orient the Robot
- The order in which you perform the operations is important.
- There are several ways to convert a vector of vectors into a matrix.
- Some ideas which can help with making the matrix: comprehensions, for loops, [`hcat`][hcat-ref], [`reshape`][reshape-ref], [`stack`][stack-ref], etc...

## 2. Rotate the Robot
- See Introduction for how to rotate a matrix.
- Simple matrix multiplication is all that is needed.

## 3. Check for Correct Orientation
- Remember, it is the *second* column of the matrix which indicates orientation.
- This can be checked with a dot product.
- It might be helpful to normalize the vectors.
- The following identity could be helpful: `x⋅y = ||x||*||y||cos(θ)` where [`||x|| = norm(x)`][norm-ref] 

## 4. Robot Body Coordinates
- This is very straightforward, but elementwise operations are important.
- Remember the orientation matrix can be seen as three position vectors from the origin.

[hcat-ref]: https://docs.julialang.org/en/v1/base/arrays/#Base.hcat
[reshape-ref]: https://docs.julialang.org/en/v1/base/arrays/#Base.reshape
[stack-ref]: https://docs.julialang.org/en/v1/base/arrays/#Base.stack
[norm-ref]: https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#LinearAlgebra.norm
