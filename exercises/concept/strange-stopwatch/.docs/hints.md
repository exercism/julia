# Hints

## 1. Define a 2D vector rotation function

- [Euler's formula][euler] is your friend here.
- The inbuilt [`complex(x, y)`][complex] method is more efficient than assigning `x + im*y`.
- There are methods for retrieving the [real][real] part and [imaginary][imaginary] part of a complex number, or both!

## 2. Define a function to find the angle of the stopwatch's hand

- The inbulit [`angle`][angle] method can be used to quickly find an argument from a complex number.
- You may want to use your `rotation` function with `angle` because you will need a rotation to redefine the zero point, since `angle` uses the convention of having zero on the negative x-axis.
- A translation would also be needed when using `angle` since the convention used has angles between -π and π.

## 3. Define a function to tell the time on the stopwatch

- Use your `timearg` function.
- There is an inbuilt method [rad2deg][rad2deg] to convert from radians to degrees.
- Minutes are the [`abs`][abs] value of the vector.

## 4. Define a function to set a timer

- Consider using the [polar form][euler] of a complex number.
- A rotation may be needed to redefine the zero point.

[euler]: https://docs.julialang.org/en/v1/base/math/#Base.cis
[complex]: https://docs.julialang.org/en/v1/base/numbers/#Base.complex-Tuple{Complex}
[real]: https://docs.julialang.org/en/v1/base/math/#Base.real
[imaginary]: https://docs.julialang.org/en/v1/base/math/#Base.imag
[angle]: https://docs.julialang.org/en/v1/base/math/#Base.angle
[abs]: https://docs.julialang.org/en/v1/base/math/#Base.abs
[rad2deg]: https://docs.julialang.org/en/v1/base/math/#Base.Math.rad2deg
