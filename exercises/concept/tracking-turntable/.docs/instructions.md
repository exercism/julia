# Instructions

Turndit Inc. is producing a new turntable which can skip between tracks on a record. Nobody knows why that is a good thing, but they insist on doing it anyway, so just let them. They currently need help in figuring out how to direct the needle to the correct part of the record when desired.

There are two parts to the setup:

The needle is suspended above the turntable and can move vertically and horizontally across the record.
Since the mechanism controlling the needle moves linearly, it keeps track of its position in a pair of coordinates `(x, y)`, with the origin at the center of the record.

There is a further optical setup which keeps track of where the needle is and where the previous or next song begins.
Since the record is rotating, it's easier to track the radial difference and the angular separation between the two points, `(Δr, Δθ)`, again with the origin at the center of the record.

Turndit needs to know how to find the new `(x, y)` coordinates for the needle to move to when a different track is selected.

These operations can be done through trigonometric functions and/or rotation matrices, but they can be made simpler (and more fun, I assure you) with the use of complex numbers via rotations and radial displacements.

This ease results from Euler's elegant formula, `ℯ^(iθ) = cos(θ) + isin(θ) = x + iy`, where `i = √-1` is the imaginary unit.

For rotations, the complex number `z = x + iy`, can be rotated an angle `θ` about the origin with a simple multiplication: `z * ℯ^(iθ)`.
Note that the `x` and `y` here are just the usual coordinates on the real 2D Cartesian plane, and a positive angle results in a *counterclockwise* rotation, while a negative angle results in a *clockwise* one.

Likewise simply, a radial displacement `Δr` can be made by adding it to the magnitude `r` of a complex number in the polar form (eg. `z = r * ℯ^(iθ)` -> `z' = (r + Δr) * ℯ^(iθ)`).
Note how the angular part stays the same and only the magnitude, `r`, is varied, as expected.

## 1. Perform a 2D vector rotation

Implement the `rotate(x, y, θ)` function which takes an `x` coordinate, a `y` coordinate and an angle `θ` (in radians).
The function should rotate the point about the origin by the given angle `θ` and return the new coordinates as a tuple.

```julia-repl
julia> rotate(0, 1, π)
(0, -1)

julia> rotate(1, 1, -π/2)
(1, -1)
```
## 2. Perform a radial displacement

Implement the function `rdisplace(x, y, r)` which takes an `x` coordinate, a `y` coordinate and a radial displacement `r`.
The function should displace the point along the radius by the amount `r` and return the new coordinates as a tuple.

```julia-repl
julia> rdisplace(0, 1, 1)
(0, 2)

julia> rdisplace(1, 1, √2)
(2, 2)
```
## 3. Find desired song

Implement a function `findsong(x, y, r, θ)` which takes the x and y coordinates of the needle as well as the radial and angular displacement between the needle and the beginning of the desired song. The new coordinates should be returned as a tuple.

```julia-repl
julia> findsong(0, 1, 3, -π/2)
(4, 0)

julia> findsong(√2, √2, 0, 3π/4)
(-2, 0)
```
