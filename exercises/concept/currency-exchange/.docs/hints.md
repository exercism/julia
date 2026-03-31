# Hints

## General

## 1. Estimate value after exchange

- You can use the [division operator][division-operator] to get the value of exchanged currency.

## 2. Calculate currency left after an exchange

- You can use the [subtraction operator][subtraction-operator] to get the amount of change.

## 3. Calculate value of bills

- You can use the [multiplication operator][multiplication-operator] to get the value of bills.

## 4. Calculate number of bills

- You need to divide `amount` into `denomination`.
- To remove decimal places from a floating point value, you can use the [`floor()`][floor] function.
- You need an integer to get the exact number of bills.
 The `floor` function can take the desired output type as a parameter.

  **Note:** The [`÷` operator][div], or `div()` function, also does floor division. However, if an operand is floating point the result is still floating point.

## 5. Calculate leftover after exchanging into bills

- You need to find the remainder of `amount` that does not equal a whole `denomination`.
- The [Modulo operator][div] `%` can help find the remainder.

## 6. Calculate value after exchange

- You need to calculate `spread` percent of `exchange_rate` using multiplication operator and add it to `exchange_rate` to get the total exchange rate (see example in instructions).
- Once you have the total exchange rate from `exchange_rate`, you need to calculate the total value of an exchange.
- With the total exchange rate, the exchange can be done in three steps in the app:
    - You can calculated the exchangeable value from scratch, or...
    - You can use three of your functions from earlier tasks.
- Pay attention to the order of processing functions, 
    - Start with a function that uses an exchange rate.
    - The output of a function should hint at which is needed next.

[division-operator]: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Arithmetic-Operators
[multiplication-operator]: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Arithmetic-Operators#Arithmetic-Operators
[subtraction-operator]: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Arithmetic-Operators
[floor]: https://docs.julialang.org/en/v1/base/math/#Base.floor
[div]: https://benlauwens.github.io/ThinkJulia.jl/latest/book.html#_floor_division_and_modulus
