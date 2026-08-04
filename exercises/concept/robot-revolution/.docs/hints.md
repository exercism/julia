# Hints

## 1. Orient the Robot
- The order in which you perform the operations is important.
- There are several ways to convert a vector of vectors into a matrix: comprehensions, for loops, `stack`

## 2. Rotate the Robot
- See Introduction for how to rotate a matrix.
- Simple matrix multiplication is all that is needed.

## 3. Check for Correct Orientation
- This can be checked with a dot product.
- It might be helpful to normalize the vectors.
- The following identity could be helpful: `x⋅y = ||x||||y||cos(θ)`

## 4. Robot Body Coordinates
- This is very straightforward, but elementwise operations are important.
- Remember the orientation matrix can be seen as three position vectors from the origin.

## 5. Translate Robot
- A variation on the previous task.
- The order of operations is important.
