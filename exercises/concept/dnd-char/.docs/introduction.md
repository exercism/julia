# Introduction

## `Base.@kwdef`

The macro `Base.@kwdef` can be used to automatically define constructors that take keyword arguments for the definition of a [struct][struct].
It also allows one to set default values for fields.

For example, the following definition

```julia
Base.@kwdef struct HumanStats
    birthyear::Int
    height::Int
    mass::Int
    bmi::Float64 = mass / (0.01 * height)^2
end
```

defines three constructors at once

```julia
julia> methods(HumanStats)
# 3 methods for type constructor:
[1] HumanStats(; birthyear, height, mass, bmi) [...]
[2] HumanStats(birthyear::Int64, height::Int64, mass::Int64, bmi::Float64) [...]
[3] HumanStats(birthyear, height, mass, bmi) [...]
```

including a constructor based on keyword arguments

```julia
julia> HumanStats(
           birthyear = 2002,
           height = 193,
           mass = 83
       )
HumanStats(2002, 193, 83, 22.28247738194314)
```

whereas the standard definition

```julia
struct HumanStats
    birthyear::Int
    height::Int
    mass::Int
    bmi::Float64
end
```

only defines the following two

```julia
julia> methods(HumanStats)
# 2 methods for type constructor:
[1] HumanStats(birthyear::Int64, height::Int64, mass::Int64, bmi::Float64) [...]
[2] HumanStats(birthyear, height, mass, bmi) [...]
```

and would require manually defining a keyword-based constructor.

### When to use `Base.@kwdef`?

Keyword-based constructors are particularly useful for constructing structs that take a large number of arguments, in particular when the type or value of the arguments don't directly relate to the arguments' meanings.

Consider the following definition:

```julia
dirk = BasketballPlayer(1978, 1994, 2019, 213, 111, 42, 1998, [2011], 31560, 11489, 3651)
```

It is not clear what each value means without knowing the definition of the type.
And even in case one knows the definition, one would probably have to look up the order over and over again.

However, when using a keyboard-based constructor, their meaning is immediately obvious:

```julia
dirk = BasketballPlayer(
    birthyear = 1978,
    career_start = 1994,
    career_end = 2019,
    height = 213,
    weight = 111,
    number = 42,
    drafted = 1998,
    championships = [2011],
    points = 31560,
    rebounds = 11489,
    assists = 3651
)
```

<!-- The following type definition was used for the examples above:
```julia
struct BasketballPlayer
    birthyear::Int
    career_start::Int
    career_end::Int
    height::Int
    weight::Int
    number::Int
    drafted::Int
    championships::Vector{Int}
    points::Int
    rebounds::Int
    assists::Int
end
```
-->

~~~~exercism/caution
`Base.@kwdef` is not exported and not documented in the manual, and therefore not part of [Julia's public API][public-api].
This means its interface is technically not guaranteed to be stable and may change between minor Julia updates.

However, the macro is widely used across the ecosystem, and it's unlikely that it will be changed in a breaking way.

For more information, see:

- ["What does `@kwdef` do?"][discourse-kwdef]
- [Julia Issue #32659 to add `@kwdef` to the Manual][add-kwdef-to-manual]
- [Julia Issue #33192 to export `@kwdef`][export-kwdef]

~~~~

### Sources

1. Dirk Nowitzki, Wikipedia. (2021). https://en.wikipedia.org/w/index.php?title=Dirk_Nowitzki&oldid=1019583359 (accessed April 24, 2021).

[struct]: https://exercism.io/tracks/julia/concepts/structs
[discourse-kwdef]: https://discourse.julialang.org/t/what-does-kwdef-do/51973/2
[public-api]: https://github.com/JuliaLang/julia/pull/35715/files#diff-3591da1fafe13d9fcae96e5b32a9492c6fb68b7e33ac0810b106b09b45d59534
[add-kwdef-to-manual]: https://github.com/JuliaLang/julia/issues/32659
[export-kwdef]: https://github.com/JuliaLang/julia/issues/33192
