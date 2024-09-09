# Introduction

The entire Julia track will require you to treat your solution like small libraries, i.e. you need to define functions, types etc. which will then be run against a test suite.
For that reason, we will introduce named functions as the very first concept.

Julia is a dynamic, strongly-typed programming langauge.
The programming style is mainly functional, though with more flexibility than in languages such as Haskell.

## Variables and assignment

There is no need to declare a variable in advance.
Just assign a value to a suitable name:

```julia-repl
julia> myvar = 42  # an integer
42

julia> name = "Maria"  # strings are surrounded by double-quotes ""
"Maria"
```

## Constants

If a value needs to be available throughout the program, but is not expected to change, it is best to mark it as a constant.

Prefacing an assignment with the `const` keyword allows the compiler to generate more efficient code than is possible for a variable.

Constants also help to protect you against errors in coding.
Accidentally trying to change the `const` value will give a warning:

```julia-repl
julia> const answer = 42
42

julia> answer = 24
WARNING: redefinition of constant Main.answer. This may fail, cause incorrect answers, or produce other errors.
24
```

Note that a `const` can only be declared *outside* any function.
This will typically be near the top of the `*.jl` file, before the function definitions.

## Arithmetic operators

These mostly work conventionally:

```julia
2 + 3  # 5 (addition)
2 - 3  # -1 (subtraction)
2 * 3  # 6 (mutlplication)
8 / 2  # 4.0 (division with floating-point result)
8 % 3  # 2 (remainder)
```

## Functions

There are two common ways to define a named function in Julia:

1. Using the `function` keyword

    ```julia
    function muladd(x, y, z)
        x * y + z
    end
    ```

    Indentation by 4 spaces is conventional for readability, but the compiler ignores this.
    The `end` keyword is essential.

    Note that we could have written `return x * y + z`.
    However, Julia functions always return the last expression evaluated, so the `return` keyword is optional.
    Many programmers prefer to include it to make their intentions more explicit.

2. Using the "assignment form"

    ```julia
    muladd(x, y, z) = x * y + z
    ```

    This is most commonly used for making concise single-expression functions.

    A `return` keyword is *never* used in the assignment form.

The two forms are equivalent, and are used in exactly the same way, so choose whichever is more readable.

Invoking a function is done by specifying its name and passing arguments for each of the function's parameters:

```julia
# invoking a function
muladd(10, 5, 1)

# and of course you can invoke a function within the body of another function:
square_plus_one(x) = muladd(x, x, 1)
```

## Naming conventions

Like many languages, Julia requires that names (of variables, functions, and many other things) start with a letter, followed by any combination of letters, digits and underscores.

By convention, variable, constant, and function names are *lowercase*, with underscores kept to a reasonable minimum.
