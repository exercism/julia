# About

Julia is a dynamic, strongly-typed programming language.
The programming style is mainly functional, though with more flexibility than in languages such as Haskell.

There is a strong and versatile type system, which will become important in later concepts. 
In practice, Julia will usually infer a suitable default from the context.

Despite its emphasis on readability, making it appear as a scripting language like Python and Ruby, Julia code is compiled before running.
The Just In Time (JIT) compiler produces highly optimized code for each function as it is enountered, leading to high runtime speed.

Julia is not an object-oriented language, and there is no class hierarchy of the sort central to many other languages.

Instead *(and please don't panic as you read this!)*, Julia relies on:
- A *Type* hierarchy.
- *Composable* functions (designed to combine easily, in versatile and powerful ways).
- *Multiple dispatch*, meaning functions can be called with variable number and types of arguments.

These rather confusing terms should become clearer as we progress through the syllabus.

The [official documentation][official-documentation] contains a lot of valuable information for the current release, though it can be a bit overwhelming for beginners.

- [Manual][manual]
- [Tutorials][tutorials]
- [Get Started with Julia][get-started]
- [Notes for Python programmers][diff-python]
- [Notes for R programmers][diff-r]
- [Notes for C/C++ programmers][diff-c]
- [Notes for Matlab programmers][diff-matlab] (this is a proprietary language, very popular with engineers and one inspiration for Julia)

Videos include:
- [A Brief Introduction to Julia][erik] from the Exercism management!
- [A Gentle Introduction to Julia][gentle-intro]
- [Learn Julia With Us][learn-with-us] : a 4-part series

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

To create a [variable][variables], just assign a value to it:

```julia-repl
julia> myvar = 42  # an integer (in fact, Int64)
42

julia> bigint = 1_234_567_890  # optionally use underscore as digit separator, for readability
1234567890

julia> name = "Maria"  # strings are surrounded by double-quotes ""
"Maria"
```

Assignment ["binds"][binding] a value to the variable.

Specifying a type is optional, and mostly Julia will infer a suitable default from the context.

Types are an important subject in Julia.
We will explore them further in later concepts.
For now, it is best not to worry about them.

In contrast to many functional languages, variables in Julia can be reassigned, and you are free to change both the *value* and the *type* bound to the variable:

```julia-repl
julia> myvar = 3
3

julia> myvar = "now a string"
"now a string"
```

## Constants

Global variables, created outside any function, are:
- Allowed.
- Sometimes necessary.
- Usually discouraged (though only within `*.jl` files; the REPL operates differently).

If a value needs to be available throughout the program, but is not expected to change, use a [constant][constants] instead.

Prefacing the assignemt with the `const` keyword allows the compiler to generate more efficient code.

Accidentally trying to change the `const` value will give a warning:

```julia-repl
julia> const answer = 42
42

julia> answer = 24
WARNING: redefinition of constant Main.answer. This may fail, cause incorrect answers, or produce other errors.
24
```

## Arithmetic operators

[Arithmetic][operators] mostly works conventionally:

```julia
2 + 3  # 5 (addition)
2 - 3  # -1 (subtraction)
2 * 3  # 6 (multiplication)
8 / 2  # 4.0 (division)
8 % 3  # 2 (remainder)
2 ^ 3  # 8 (exponentiation)
```

Note that division with `/` always gives a floating-point value.

We will return to this in later concepts, which will discuss integer division with `div()` or `÷` to truncate and `//` to get a rational number.

## Functions

For best runtime performance, it is best to place most of the code inside [functions][functions]. 
Having lots of small functions is fine, in contrast to some other languages.

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

From the fact that we refer to these as "named" functions, you might guess that there are also "anonymous" functions.
These will be covered in a later concept.

## Naming conventions

Like many languages, Julia [requires][naming] that names (of variables, functions, and many other things) start with a letter, followed by any combination of letters, digits and underscores.

By convention, variable, constant and function names are *lowercase*, with underscores avoided except when needed to avoid confusion.

However, Julia uses [Unicode][unicode] throughout, so "letter" is interpreted quite flexibly.

Languages other than English are supported, so are emojis *(though please use good taste and pick something appropriate)*.

In particular, all the Greek letters loved by mathematicians are available *(and several useful values are pre-defined)*:

```julia-repl
julia> π   # a built-in constant
π = 3.1415926535897...
```

Julia-aware editors, including the REPL, Pluto.jl, and VS Code with the Julia plugin, make these characters easy to enter.

For π, type `\pi` then hit `<Tab>`. Your typing will be replaced by the Greek character.

You will see many more examples of this in later concepts.

In fact, the backslash-abbreviations are not something specific to Julia.
They are taken from [LaTeX][latex], a typesetting system that many scientists and engineers use almost daily to write reports.

[official-documentation]: https://docs.julialang.org/en/v1/
[manual]: https://docs.julialang.org/en/v1/manual/getting-started/
[tutorials]: https://julialang.org/learning/tutorials/
[diff-python]: https://docs.julialang.org/en/v1/manual/noteworthy-differences/#Noteworthy-differences-from-Python
[diff-r]: https://docs.julialang.org/en/v1/manual/noteworthy-differences/#Noteworthy-differences-from-R
[diff-c]: https://docs.julialang.org/en/v1/manual/noteworthy-differences/#Noteworthy-differences-from-C/C
[diff-matlab]: https://docs.julialang.org/en/v1/manual/noteworthy-differences/#Noteworthy-differences-from-MATLAB
[get-started]: https://julialang.org/learning/
[erik]: https://www.youtube.com/watch?v=X4Alzh3QyWU
[gentle-intro]: https://www.youtube.com/watch?v=4igzy3bGVkQ
[learn-with-us]: https://www.youtube.com/watch?v=oTUmW8dWZws
[variables]: https://docs.julialang.org/en/v1/manual/variables/
[constants]: https://docs.julialang.org/en/v1/manual/variables-and-scoping/#Constants
[operators]: https://docs.julialang.org/en/v1/manual/mathematical-operations/
[functions]: https://docs.julialang.org/en/v1/manual/functions/
[naming]: https://docs.julialang.org/en/v1/manual/variables/#man-allowed-variable-names
[unicode]: https://en.wikipedia.org/wiki/Unicode
[latex]: https://en.wikipedia.org/wiki/LaTeX
[binding]: https://docs.julialang.org/en/v1/manual/variables/#man-assignment-expressions
