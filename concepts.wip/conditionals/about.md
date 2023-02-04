# About

Conditional evaluation is when certain checks have to be made to see if a _conditional_ (expession) is satisfied before we can execute a set of statements in our program.

This is where Julia provides the following ways to control the flow of our program.

There are three primary conditional statements that are used in Julia:

- [`if`-expressions](https://exercism.lol/tracks/julia/concepts/if-expressions)
- [The ternary operator](https://exercism.lol/tracks/julia/concepts/ternary-operator)
- [Short-circuit evaluation](https://exercism.lol/tracks/julia/concepts/short-circuit-evaluation)

Take note of the following, in Julia the _conditional expression_ must return `true` or `false`. Otherwise it is an error.

```julia
julia> if 1
           println("true")
       end
ERROR: TypeError: non-boolean (Int64) used in boolean context
```