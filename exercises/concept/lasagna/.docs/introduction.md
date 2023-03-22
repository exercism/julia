# Introduction

The entire Julia track will require you to treat your solution like small libraries, i.e. you need to define functions, types etc. which will then be run against a test suite.
For that reason, we will introduce named functions as the very first concept.

## Functions

### Defining functions

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

### Invoking functions

Invoking a function is done by specifying its name and passing arguments for each of the function's parameters:

```julia
# invoking a function
muladd(10, 5, 1)

# and of course you can invoke a function within the body of another function:
square_plus_one(x) = muladd(x, x, 1)
```

## Integers and Arithmetic operations

Integer literals in Julia are represented in the usual way.
Underscores may be used as a digit separator.

```julia-repl
julia> 1
1

julia> -1234
-1234

julia> 1_234_567_890
1234567890
```

### Arithmetic operations

The standard prefix and infix operations are available: `+`, `-`, `*`, `%`.

```julia-repl
julia> +16
16

julia> -16
-16

julia> 16 + 6
22

julia> 16 - 6
10

julia> 16 * 6
96

julia> 16 % 6
4
```

#### Division

Dividing two numbers with the `/` operator will result in a floating point value.
To perform integer division

- use the `div(x, y)` function, or
- use the `÷` operator (Julia source code is unicode-aware)

```julia-repl
julia> 16 / 6
2.6666666666666665

julia> div(16, 6)
2

julia> 16 ÷ 6
2
```

~~~~exercism/note
It's natural to use Unicode symbols in Julia source files, typically in mathematical expressions.
When using the Julia REPL, or in other Julia editing environments, the division symbol can be entered by typing `\div` followed by the `Tab` key.
More details can be found in the manual at [Unicode Input][unicode].

[unicode]: https://docs.julialang.org/en/v1/manual/unicode-input/#Unicode-Input
~~~~

## Comments

Julia supports two kinds of comments.
Single line comments are preceded by `#` and multiline comments are inserted between `#=` and `=#`.

```julia
add(1, 3) # returns 4

#= Some random code that's no longer needed but not deleted
sub(x, y) = x - y
mulsub(x, y, z) = sub(mul(x, y), z)
=#
```

## Types

Depending on which other programming languages you know, you may expect parameters, variables or return values to have explicit type annotations.
For now, assume that Julia will infer the types automagically and don't worry about them, we will get to the specifics of the type system in later exercises.
