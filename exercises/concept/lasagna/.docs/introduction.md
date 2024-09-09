# Introduction

The entire Julia track will require you to treat your solution like small libraries, i.e. you need to define functions, types etc. which will then be run against a test suite.
For that reason, we will introduce named functions as the very first concept.

Julia is a dynamic, strongly-typed programming langauge.
The programming style is mainly functional, though with more flexibility than in languages such as Haskell.

## Comments

Two options are possible in Julia:
- Single-line comments start with `#`
- Multi-line comments start with `#=` and end with `=#`. Nesting is allowed.

```julia
# This is a single-line comment

x = 3  # This is an inline comment

#=
	Multi-line comments can be used for longer explanations.

	They are especially useful to comment out blocks of code during debugging.
=#
```

## Variables and assignment

To create a variable, just assign a value to it:

```julia-repl
julia> myvar = 42  # an integer
42

julia> name = "Maria"  # strings are surrounded by double-quotes ""
"Maria"
```

Types are an important subject in Julia, but for now it is best to ignore them them.
The compiler will infer a suitable type for any expression you use.

## Constants

Global variables, created outside any function, are:
- Allowed.
- Sometimes necessary.
- Usually discouraged (only within `*.jl` files; the REPL operates differently).

If a value needs to be available throughout the program, but is not expected to change, use a constant instead.

Prefacing the assignment with the `const` keyword allows the compiler to generate more efficient code.

Accidentally trying to change the `const` value will give a warning:

```julia-repl
julia> const answer = 42
42

julia> answer = 24
WARNING: redefinition of constant Main.answer. This may fail, cause incorrect answers, or produce other errors.
24
```

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
    The `end` keyword is essential: more like Ruby than like Python.

    Note that we could have written `return x * y + z`. 
    However, Julia functions always return the last expression evaluated, so the `return` keyword is optional.
    Many programmers prefer to include it to make their intentions more explicit.

2. Using the "assignment form"

    ```julia
    muladd(x, y, z) = x * y + z
    ```

    This is most commonly used for one-line function definitions or mathematical functions, where the function body is a single expression.
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

However, Julia uses Unicode throughout, so "letter" is interpreted quite flexibly: not just *English* letters.
