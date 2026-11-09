# Hints

## General

- You will need to define [functions][functions] and use [arithmetic operators][arithmetics].

## 1. Store the expected bake time in a constant

- Define a [const][const] to store this value.

## 2. Calculate the preparation time in minutes

- Use the [`times` arithmetic operator][arithmetics] to multiply the argument by `2`.

## 3. Calculate the remaining oven time in minutes

- Use the [`minus` arithmetic operator][arithmetics] to subtract the argument from `60`.

## 4. Calculate the total working time in minutes

- Reuse the `preparation_time` function defined in the first step.
- Use the [`plus` arithmetic operator][arithmetics] to add the return value of `preparation_time` to the argument.

[const]: https://docs.julialang.org/en/v1/base/base/#const
[functions]: https://docs.julialang.org/en/v1/manual/functions/
[arithmetics]: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Arithmetic-Operators-1
