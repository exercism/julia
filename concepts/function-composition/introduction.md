# Introduction

Julia encourages programmers to put as much code as possible inside functions that can be JIT-compiled, and creating many small functions is, by design, performant.

That tends to leave many small, simple functions, which need to be combined to carry out non-trivial tasks.

One obvious approach is to nest function calls.
The following example is very contrived, but illustrates the point.

```julia-repl
julia> first.(titlecase.(reverse.(["my", "test", "strings"])))
3-element Vector{Char}:
 'Y': ASCII/Unicode U+0059 (category Lu: Letter, uppercase)
 'T': ASCII/Unicode U+0054 (category Lu: Letter, uppercase)
 'S': ASCII/Unicode U+0053 (category Lu: Letter, uppercase)
```

The disadvantage of this approach is that readability drops rapidly as nesting gets deeper.

We need a simpler and more flexible approach.

## Composition

This is the technique beloved of mathematicians, and Julia copies the mathematical syntax.

An arbitrary number of functions can be [`composed`][comp] together with `∘` operators (entered as `\circ` then tab).
The result can be used as a single function.

```julia-repl
julia> compfunc = first ∘ titlecase ∘ reverse
first ∘ titlecase ∘ reverse
julia> compfunc.(["my", "test", "strings"])
3-element Vector{Char}:
 'Y': ASCII/Unicode U+0059 (category Lu: Letter, uppercase)
 'T': ASCII/Unicode U+0054 (category Lu: Letter, uppercase)
 'S': ASCII/Unicode U+0053 (category Lu: Letter, uppercase)
# alternative syntax, giving the same result
julia> (first ∘ titlecase ∘ reverse).(["my", "test", "strings"])
```

A couple of points to note:

- The starting functions appear in the same order as when nesting, and are executed in right-to-left order.
- Broadcasting is not simple to use when composing, but can be applied when calling the composed function.

## Pipelining

An alternative might be thought of as the _programmers'_ approach, rather than the _mathematicians'_.

[`Pipelines`][comp] have long been used in Unix shell scripts, and more recently became popular in mainstream programming languages (F# is sometimes credited with pioneering their adoption).

The basic concept is to start with some data, then pipe it through a sequence of functions to get the result.

The pipe operator is `|>` (as in F# and recent versions of R), though Julia also has a broadcast version `.|>`.

```julia-repl
julia> ["my", "test", "strings"] .|> reverse .|> titlecase .|> first
3-element Vector{Char}:
 'Y': ASCII/Unicode U+0059 (category Lu: Letter, uppercase)
 'T': ASCII/Unicode U+0054 (category Lu: Letter, uppercase)
 'S': ASCII/Unicode U+0053 (category Lu: Letter, uppercase)
```

Execution is now strictly left-to-right, with the output of each function flowing in the direction of the arrow to become the input for the next function.

## Limitations, workarounds, and other options

It is no coincidence that the functions used to illustrate composition and pipelining all take a _single_ argument.

Some purely-functional languages, pipe the _first_ argument into a function but allow others to be included.

In contrast, Julia only expects function _names_ (or something equivalent) in a pipeline, without any additional arguments.

There are important technical reasons for this (related to the fact that [`currying`][currying] is not a standard part of the language design).
The _many_ people who have no understanding of currying should merely accept that this limitation is not a careless oversight, and is not likely to change in future Julia versions.

### Workarounds

We need single-arguments functions that do whatever is needed.
Fortunately, defining new functions in Julia is easy.

Most simply, we could use an [`anonymous function`][anonymous-function].
For example, if we have a single input string and we want to split on underscores:

```julia-repl
julia> "my_test_strings" |> (s -> split(s, '_'))
3-element Vector{SubString{String}}:
 "my"
 "test"
 "strings"
```

That vector could then be piped to other functions, as before.

Enclosing the anonymous function in parentheses is optional in this case, but more generally is a useful way to reduce ambiguity.

Equally, we could create a named function, earlier in the program, and reuse it as needed.

[comp]: https://docs.julialang.org/en/v1/manual/functions/#Function-composition-and-piping
[currying]: https://en.wikipedia.org/wiki/Currying
[anonymous-function]: https://docs.julialang.org/en/v1/manual/functions/#man-anonymous-functions
