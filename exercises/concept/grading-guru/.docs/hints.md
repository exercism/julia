# Hints

## 1. Demote the grades

- There are separate ways to compare a concrete or an abstract type (see introduction).
- The [`ceil`][ceiling] function can take a type as an argument for the desired output type.
- The [`convert`][convert] function is a general way to convert between types.
- Remember, there is a function which returns the type of any input (which may be handy for the error message).
- You can read more about [`throw`][throw] and [MethodError][methoderror] in the docs.

## 2. Preprocess the data

- `Vector`s and `Set`s can be assumed to be abstract types here, as far as comparisons are concerned.
- Use your `demote` function to convert the grades.
- Only reverse the vector (`O(N)`), do not sort it (`O(NlogN)`).
- You can read more about [`throw`][throw] and [MethodError][methoderror] in the docs.

[ceiling]: https://docs.julialang.org/en/v1/base/math/#Base.ceil
[convert]: https://docs.julialang.org/en/v1/base/base/#Base.convert
[throw]: https://docs.julialang.org/en/v1/base/base/#Core.throw
[methoderror]: https://docs.julialang.org/en/v1/base/base/#Core.MethodError
