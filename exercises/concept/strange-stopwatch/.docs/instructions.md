# Instructions

You've been given a strange stopwatch which has no markings on it but takes 60 seconds to go around once.
What's stranger is that the hand grows by one unit with each passing minute.

To read the time on stopwatch you can place it on some graph paper and read off the x-y coordinates.
Then we will have to convert these coordinates into minutes and seconds.

On the other hand, we may want to use it as a timer, so we need to be able to put a mark on the paper as a reference time.
Here we will have to convert the minutes and seconds into the x-y coordinates.

These operations can be done through trigonometric functions and/or rotation matrices, but they can be made simpler (and more fun, I assure you) with the use of complex numbers.
This ease, which can make rotations quite straightforward, results from Euler's elegant formula, `ℯ^(iθ) = cos(θ) + isin(θ) = x + iy`, where `i = √-1` is the imaginary unit.
For example, the complex number `z = x + iy`, can be rotated about the origin with a simple multiplication `z * ℯ^(-iθ)`.
Here the `x` and `y` are just the coordnates on a real 2D plane.
**Caveat:** A *clockwise* rotation takes a negative exponent, `ℯ^(-iθ) = cos(θ) - isin(θ)`, and a *counterclockwise* rotation takes a positive one, `ℯ^(iθ) = cos(θ) + isin(θ)`.

## 1. Define a 2D vector rotation function

Implement the `rotate` function which takes an x coordinate, a y coordinate and an angle θ (in radians).
The function should rotate the point about the origin by the given angle θ and return the new coordinates as a tuple.
While our stopwatch hand will only have integer lengths, this function should rotate a vector of any length.

```julia-repl
julia> rotate(0, 1, π)
(0, -1)

julia> rotate(1, 1, π)
(-1, -1)
```

## 2. Define a function to find the angle of the stopwatch's hand

Implement the function `timearg` which takes the x-y coordinates the hand and returns the angle in radians.
Since we are dealing with a clock, the zero point will be on the y-axis (i.e. imaginary axis).


```julia-repl
julia> timearg(0, 1)
0

julia> timearg(1, 0)
1.5707963267948966  # equal to π/2
```

## 3. Define a function to tell the time on the stopwatch

Implement a function `readtime` which takes the x-y coordinates of the hand and returns the time as `"Mm Ss"`.


```julia-repl
julia> readtime(1, 0)
"1m 15.0s"

julia> readtime(√2, √2)
"2m 7.5s"
```

## 4. Define a function to set a timer

Implement a function `getcoords` which takes a time, in minutes and seconds, and outputs the x-y coordinates of the tip of the stopwatch's hand at that time.

```julia-repl
julia> getcoords(1, 0)
(0, 1)

julia> getcoords(2, 15)
(2, 0)
```