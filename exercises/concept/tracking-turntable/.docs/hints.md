# Hints

Using complex numbers for rotations in 2D can leave things much cleaner and numerically more precise.

## 1. Construct a complex number from Cartesian coordinates

- The inbuilt [`complex(x, y)`][complex] method is more efficient than assigning `x + im*y`.
- See the introduction for a review.

## 2. Construct a complex number from Polar coordinates

- There are a few equivalent ways to do this (e.g. `exp`, `cis`, `cispi`). 
- See the introduction and instructions for further review.

## 3. Perform a 2D vector rotation

- [Euler's formula][euler] is your friend here and you could use your `euler` function.
- There are methods for retrieving the [real][real] part and [imaginary][imaginary] part of a complex number, or both!

## 4. Perform a radial displacement

- Your `euler` function can be of use, or not...
- The inbulit [`angle`][angle] method can be used to quickly find an argument from a complex number.
- The [`abs`][abs] method can be used to find the magnitude of a complex number.

## 5. Find the desired song

- This is a good opportunity to compose your `rotate` and `rdisplace` functions.

[euler]: https://docs.julialang.org/en/v1/base/math/#Base.cis
[complex]: https://docs.julialang.org/en/v1/base/numbers/#Base.complex-Tuple{Complex}
[real]: https://docs.julialang.org/en/v1/base/math/#Base.real
[imaginary]: https://docs.julialang.org/en/v1/base/math/#Base.imag
[angle]: https://docs.julialang.org/en/v1/base/math/#Base.angle
[abs]: https://docs.julialang.org/en/v1/base/math/#Base.abs
