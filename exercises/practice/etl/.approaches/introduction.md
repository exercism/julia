# Introduction

## Approach: `for` loops

The core algorithm for solving this problem is to use nested `for` loops to accumulate pairs of values into a new dictionary.

```julia
function transform(input)
    result = Dict()
    for (point, letters) in input
        for letter in letters
            result[lowercase(letter)] = point
        end
    end
    return result
end
```

We can refine this solution slightly by using Julia's concise syntax for nested `for` loops and by specifying the type parameters for the `Dict` (concrete types often allow the compiler to generate better code).

```julia
function transform(input)
    result = Dict{Char, Int}()
    for (point, letters) in input, letter in letters
        result[lowercase(letter)] = point
    end
    return result
end
```


## Approach: A generator

The constructor for `Dict` accepts an iterable of `key => value` pairs and we can express an iterable like that with a [generator expression](https://docs.julialang.org/en/v1/manual/arrays/#Generator-Expressions), even when we need to do nested iteration, as in this example.

```julia
function transform(input)
    Dict(
        lowercase(letter) => point
        for (point, letters) in input
        for letter in letters
    )
end
```

This solution is efficient, concise and yields a `Dict` parameterised by the concrete types that we'd want (`Dict{Char, Int}`), without us needing to explicitly specify them.
