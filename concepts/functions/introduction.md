# Introduction

## Defining functions

There are two common ways to define a named function in Julia:

1. Using the `function` keyword

    ```julia
    function muladd(x, y, z)
        return x * y + z
    end
    ```

2. Using the "assignment form"

    ```julia
    muladd(x, y, z) = x * y + z
    ```

    This is most commonly used for one-line function definitions or mathematical functions, where the function body is a single expression.

## Invoking functions

Invoking a function is done by specifying its name and passing arguments for each of the function's parameters:

```julia
# invoking a function
muladd(10, 5, 1)

# and of course you can invoke a function within the body of another function:
square_plus_one(x) = muladd(x, x, 1)
```
