# Introduction

This exercise will introduce you to Julia's key paradigm: Multiple Dispatch.
You will learn how Julia determines which function to call by generating random values.

## Types

All values in Julia have a type.

You can find out the type of a value using the `typeof` function:

```julia-repl
julia> typeof(2)
Int64

julia> typeof(2.0)
Float64

julia> typeof("Hello, World!")
String

julia> typeof(true)
Bool
```

<!-- TODO Explain somewhere that expressions have values and therefore types.
julia> typeof(2 + 2 == 4)
Bool
-->

~~~~exercism/note
By convention, UpperCamelCase is used for type names.
~~~~

## Methods

TODO: Explain how Julia determines which `rand` method to call, and what methods actually are.

Defining several methods of a function yourself will be covered in a later exercise.

## Randomness

`rand` is a function used to generate random values.

Called without arguments, it returns a random `Float64` in `[0, 1)`, i.e. `0 <= rand() < 1`.

```julia-repl
julia> rand()
0.2052547979867787

julia> rand()
0.4931832903694542
```

`rand` is an example of a function that behaves differently depending on the type of its given arguments.
It has 68 methods[^1].

```julia-repl
julia> rand
rand (generic function with 68 methods)
```

You can use it to generate random values of many different types.
For example, to generate a random [boolean](/tracks/julia/concepts/booleans) value, use

```julia-repl
julia> rand(Bool)
true
```

You can also use it to choose a random value from a collection, such as a range or [vector](/tracks/julia/concepts/vectors):

```julia-repl
julia> rand(1:10)
3

julia> rand([1, 1, 2, 3, 5, 8, 13])
8
```

[^1]: As of Julia 1.6.1
