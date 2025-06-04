# Instructions

Turndit Inc. is producing a new turntable which can skip between tracks on a record. Nobody knows why that is a good thing, but they insist on doing it anyway, so just let them. They currently need help in figuring out how to direct the needle to the correct part of the record when desired.

There are two parts to the setup:

The needle is suspended above the turntable and can move left/right and forwards/backwards across the record (think claw machine!).
Since the mechanism controlling the needle moves linearly, it keeps track of its position in a pair of coordinates `(x, y)`, with the origin at the center of the record.

There is a further optical setup which keeps track of where the needle is and where the previous or next song begins.
Since the record is rotating, it's easier to track the radial difference and the angular separation between the two points, `(r, θ)`, again with the origin at the center of the record.

Turndit needs to know how to find the new `(x', y')` coordinates to which the needle will move when a different track is selected.

~~~~exercism/note
These operations can be done through trigonometric functions and/or rotation matrices, but they can be made simpler (and more fun, I assure you!) with the use of complex numbers via rotations and radial displacements. 
In fact, each function in this exercise can be written in assigment form (i.e. a one-liner) using complex numbers and built-in Julia methods/functionality, should you so desire.
~~~~

## 1. Construct a complex number from Cartesian coordinates

Implement the `z(x, y)` function which takes an `x` coordinate, a `y` coordinate from the complex plane and returns the equivalent complex number.

```julia-repl
julia> z(1, 1)
1.0 + 1.0im

julia> z(4.5, -7.3)
4.5 - 7.3im
```

## 2. Construct a complex number from Polar coordinates

Implement the `euler(r, θ)` function, which takes a radial coordinate `r`, an angle `θ` (in radians) and returns the equivalent complex number in rectangular form.

```julia-repl
julia> euler(1, π)
-1.0 + 0.0im

julia> euler(3, π/2)
0.0 + 3.0im

julia> euler(2, -π/4)
1.4142135623730951 - 1.414213562373095im  # √2 - √2im
```

## 3. Perform a 2D vector rotation

Implement the `rotate(x, y, θ)` function which takes an `x` coordinate, a `y` coordinate and an angular displacement `θ` (in radians).
The function should rotate the point about the origin by the given angle `θ` and return the new coordinates as a tuple: `(x', y')`.

```julia-repl
julia> rotate(0, 1, π)
(0, -1)

julia> rotate(1, 1, -π/2)
(1, -1)
```
## 4. Perform a radial displacement

Implement the function `rdisplace(x, y, r)` which takes an `x` coordinate, a `y` coordinate and a radial displacement `r`.
The function should displace the x-y coordinates along the radius by the amount `r` and return the new coordinates as a tuple `(x', y')`.

```julia-repl
julia> rdisplace(0, 1, 1)
(0, 2)

julia> rdisplace(1, 1, √2)
(2, 2)
```
## 5. Find the desired song

Implement a function `findsong(x, y, r, θ)` which takes the x and y coordinates of the needle as well as the r and θ displacement between the needle and the beginning of the desired song. The new coordinates of the needle should be returned as a tuple `(x', y')`.

```julia-repl
julia> findsong(0, 1, 3, -π/2)
(4, 0)

julia> findsong(√2, √2, 0, 3π/4)
(-2, 0)
```
