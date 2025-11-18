# Introduction

You can solve this exercise a great number of ways!

Because this is a very small problem, almost any solution is likely to be fast enough for most purposes.

Clarity and readability are generally the priority, though we will make a few comments on performance in proparation for future challenges where speed matters. 

## Example solutions

The fastest solutions avoid constructing new strings unless they have to, and instead return one of several statically allocated strings when the input number is divisible by 3, 5, or 7.

Simpler or more flexible solutions construct strings through concatenation.

The example solutions below are roughly in run time order (fastest first), but all of them are satisfactory solutions to the problem.

### if / else tree

A clear but verbose approach uses nested `if...else` blocks:

```julia
function raindrops1(number)
    # pre-calculate factors
    f3 = number % 3 == 0
    f5 = number % 5 == 0
    f7 = number % 7 == 0

    if f3
        if f5
            if f7
                "PlingPlangPlong"
            else
                "PlingPlang"
            end
        else
            if f7
                "PlingPlong"
            else
                "Pling"
            end
        end
    else
        if f5
            if f7
                "PlangPlong"
            else
                "Plang"
            end
        else
            if f7
                "Plong"
            else
                string(number)
            end
        end
    end
end
```

More concisely, we could replace the innermost `if...else` with ternary operators:

```julia
function raindrops1a(number)
    # pre-calculate factors
    f3 = number % 3 == 0
    f5 = number % 5 == 0
    f7 = number % 7 == 0

    if f3
        if f5
            f7 ? "PlingPlangPlong" : "PlingPlang"
        else
            f7 ? "PlingPlong" : "Pling"
        end
    else
        if f5
            f7 ? "PlangPlong" : "Plang"
        else
            f7 ? "Plong" : string(number)
        end
    end
end
```

While ternary operators can be nested, that quickly becomes confusing and offers little further advantage.

### Lookup

A lookup table is another good option.

The example below uses [bitwise][concept-bitwise] operators:

```julia
function raindrops2(number)
    i = 0
    i |= (number % 3 == 0)       # 001
    i |= (number % 5 == 0) << 1  # 010
    i |= (number % 7 == 0) << 2  # 100

    if i == 0
        return string(number)
    else
        return @inbounds (
            "Pling",            # 001
            "Plang",            # 010
            "PlingPlang",       # 011
            "Plong",            # 100
            "PlingPlong",       # 101
            "PlangPlong",       # 110
            "PlingPlangPlong",  # 111
        )[i]
    end
end
```

The [`@inbounds()` macro][ref-bounds] disables bounds checking, as a (risky) performance enhancement.
Use with caution!

### Switch

A slightly slower version formatted as a single switch rather than a tree of ifs.

```julia
function raindrops3(number)
    f3 = number % 3 == 0
    f5 = number % 5 == 0
    f7 = number % 7 == 0

    if f3 & f5 & f7
        "PlingPlangPlong"
    elseif f3 & f5 & !f7
        "PlingPlang"
    elseif f3 & !f5 & f7
        "PlingPlong"
    elseif f3 & !f5 & !f7
        "Pling"
    elseif !f3 & f5 & f7
        "PlangPlong"
    elseif !f3 & f5 & !f7
        "Plang"
    elseif !f3 & !f5 & f7
        "Plong"
    else
        string(number)
    end
end
```

The following three solutions are slower but make use of concatenation so as to be more concise, readable or extendable.

### Compact, with short-circuiting

This solution is short, easy to read and almost as fast in the average case as the solutions above!

It is fast because it avoids one string concatenation in the common case that `number` is divisible by 3
and when `number` is divisible by 3, but not 5 and 7, the statically allocated string "Pling" is returned almost instantly.

```julia
function raindrops4(number)
    s = ""
    # The first equals here lets us avoid dynamically allocating a string 
    # in the case that number is only divisible by 3.
    number % 3 == 0 && (s = "Pling")
    number % 5 == 0 && (s *= "Plang")
    number % 7 == 0 && (s *= "Plong")
    isempty(s) && (s = string(number))
    return s
end
```

### Extendable

[cmcaine's solution](https://exercism.io/tracks/julia/exercises/raindrops/solutions/d558034438c64bb9a949f90cfcdaad6a)

A solution (over?)designed to be easily extended or changed if the `noises` spec changed. 

Some similar solutions use a `Dict` rather than a tuple, but a tuple of pairs is simpler and more efficient if you do not need to look up values by key.

```julia
function raindrops5(number)
    noises = (3 => "Pling", 5 => "Plang", 7 => "Plong")
    acc = ""
    for (factor, noise) in noises
        number % factor == 0 && (acc *= noise)
    end
    isempty(acc) ? string(number) : acc
end
```

### IOBuffer

Using an [`IOBuffer`][ref-IOBuffer] to create a string on the fly is a common pattern in Julia. 

However, for this exercise, it tends to be rather slow compared to the other solutions.
Presumably, this problem is so small that the fixed overhead of `IOBuffer` creation is not offset by avoiding a few (relatively slow) string concatenations.

```julia
function raindrops6(number)
    buf = IOBuffer(sizehint=15)

    number % 3 == 0 && write(buf, "Pling")
    number % 5 == 0 && write(buf, "Plang")
    number % 7 == 0 && write(buf, "Plong")

    if position(buf) == 0
        return string(number)
    else
        return String(take!(buf))
    end
end
```

More generally, constructing strings is slow! 
Profiling shows that `string(number)` and string concatenation are the biggest time sinks. 
Branching / lookup and remainder calculation are blazingly fast by comparison.

[concept-bitwise]: https://exercism.org/tracks/julia/concepts/bitwise-operations
[ref-IOBuffer]: https://docs.julialang.org/en/v1/base/io-network/#Base.IOBuffer
[ref-bounds]: https://docs.julialang.org/en/v1/devdocs/boundscheck/
