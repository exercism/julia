# Hints

## General

- Julia contains many mathematical functions as standard, including [`gcd()`][ref-gcd] and [`invmod()`][ref-invmod].
- In Julia, the `%` operator is the infix form of [`rem()`][ref-rem].
  - This differs from some other languages, including Python and R, where `%` has behavior more similar to Julia's [`mod()`][ref-mod].
  - The functions differ in handling of negative integers.

  [ref-gcd]: https://docs.julialang.org/en/v1/base/math/#Base.gcd
  [ref-invmod]: https://docs.julialang.org/en/v1/base/math/#Base.invmod
  [ref-rem]: https://docs.julialang.org/en/v1/base/math/#Base.rem
  [ref-mod]: https://docs.julialang.org/en/v1/base/math/#Base.mod
