# About

True or false values are represented by the `Bool` type.
It contains only two values: `true` and `false`.

`Bool` is a subtype of `Integer` and acts as one and zero numerically:

```julia
help?> Bool
search: Bool enable_autocomplete_brackets BoundsError

  Bool <: Integer


  Boolean type, containing the values true and false.

  Bool is a kind of number: false is numerically equal to 0 and true is numerically equal to 1. Moreover, false acts
  as a multiplicative "strong zero":

  julia> false == 0
  true

  julia> true == 1
  true

  julia> 0 * NaN
  NaN

  julia> false * NaN
  0.0
```

~~~~exercism/note
Be aware that the behaviour of `false` as a strong zero may not be  consistent and intuitive in all situations.
See [julialang/julia#33226](https://github.com/JuliaLang/julia/issues/33226) for more information.
~~~~

## Related concepts

- [concept:julia/boolean-expressions](../boolean-expressions/about.md)
- [concept:julia/boolean-logic](../boolean-logic/about.md)
