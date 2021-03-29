# Introduction

You'll be provided with an exemplar solution to each exercise you solve on Exercism.
On the Julia track, those solutions generally contain [docstrings](https://en.wikipedia.org/wiki/Docstring).
After solving this exercise, you will know how docstrings are structured, how to write them, and how to access docstrings through the REPL.

~~~~exercism/note
You are not required to write docstrings for your functions while solving exercises on the Julia track if you don't want to.
~~~~

## Syntax

Any string right before any kind of Julia object, e.g. a function or type, will be interpreted as a docstring documenting the object.
For example:

```julia
"Tell a joke."
joke() = ...
```

Docstrings in Julia are formatted using [Markdown](https://en.wikipedia.org/wiki/Markdown).
This allows one to use features such as indentation, code blocks, or bold text in docstrings.

~~~~exercism/note
You can find a list of supported Markdown features in the [documentation of the Markdown standard library](https://docs.julialang.org/en/v1/stdlib/Markdown/).
~~~~

A more complex docstring may look like this:

````julia
"""
    mean(x, y)

Compute the mean value of `x` and `y`.
"""
mean(x, y) = (x + y) / 2
````

The Julia Manual contains few conventions that should be followed:

> - Always show the signature of a function at the top of the documentation, with a four-space indent so that it is printed as Julia code.
> - Include a single one-line sentence describing what the function does or what the object represents after the simplified signature block.
>    If needed, provide more details in a second paragraph, after a blank line.
>    The one-line sentence should use the imperative form ("Do this", "Return that") instead of the third person (do not write "Returns the length...") when documenting functions.
>    It should end with a period.
> - Do not repeat yourself.
>    Since the function name is given by the signature, there is no need to start the documentation with "The function `mean`...": go straight to the point.
> - Use backticks to identify code and equations.
> - Place the starting and ending `"""` characters on lines by themselves.

~~~~exercism/note
The list above only covers conventions you may need or encounter in the context of Exercism.
You can find a full, unabbreviated list in the [Julia Manual](https://docs.julialang.org/en/v1/manual/documentation/).
Further conventions for documenting more advanced Julia concepts will be introduced alongside the concept in later exercises.
~~~~

## Accessing docstrings

You can search for docstrings in the REPL by typing `?` followed by the name of the function or object, e.g.

```julia-repl
help?> println
search: println printstyled print sprint isprint

  println([io::IO], xs...)


  Print (using print) xs followed by a newline. If io is not supplied, prints to stdout.

  Examples
  ==========

  julia> println("Hello, world")
  Hello, world

  julia> io = IOBuffer();

  julia> println(io, "Hello, world")

  julia> String(take!(io))
  "Hello, world\n"
```

This can also be used as a basic search, for example if you're unsure about the exact spelling of a function:

```julia-repl
help?> printline
search:

Couldn't find printline
Perhaps you meant println, pipeline, @inline or print
  No documentation found.

  Binding printline does not exist.
```

## Source

This entire document is derived from the [Documentation chapter](https://docs.julialang.org/en/v1/manual/documentation/) of the Julia Manual.
