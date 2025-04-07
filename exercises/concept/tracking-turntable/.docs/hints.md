# Hints

Using complex numbers for rotations in 2D can leave things much cleaner and numerically more precise.

## 1. Perform a 2D vector rotation

- [Euler's formula][euler] is your friend here.
- The inbuilt [`complex(x, y)`][complex] method is more efficient than assigning `x + im*y`.
- There are methods for retrieving the [real][real] part and [imaginary][imaginary] part of a complex number, or both!

## 2. Perform a radial displacement

- The inbulit [`angle`][angle] method can be used to quickly find an argument from a complex number.
- The [`abs`][abs] method can be used to find the magnitude of a complex number.

## 3. Find desired song

- This is a good opportunity to compose your `rotate` and `rdisplace` functions.

[euler]: https://docs.julialang.org/en/v1/base/math/#Base.cis
[complex]: https://docs.julialang.org/en/v1/base/numbers/#Base.complex-Tuple{Complex}
[real]: https://docs.julialang.org/en/v1/base/math/#Base.real
[imaginary]: https://docs.julialang.org/en/v1/base/math/#Base.imag
[angle]: https://docs.julialang.org/en/v1/base/math/#Base.angle
[abs]: https://docs.julialang.org/en/v1/base/math/#Base.abs
[rad2deg]: https://docs.julialang.org/en/v1/base/math/#Base.Math.rad2deg
[deg2rad]: https://docs.julialang.org/en/v1/base/math/#Base.Math.deg2rad
