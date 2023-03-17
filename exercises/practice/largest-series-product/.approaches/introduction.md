# Introduction

## General guidance

- Be careful not to use `isnumeric(c)` in your solution. When you want to test if a character is in '0':'9', use `isdigit`. Read the help to find out more (enter `?isnumeric` and press enter at a Julia REPL).

## Overflows

Products expand very quickly.
If you're multiplying more than a few integers together then you may get silent integer overflow and garbage results!
Consider calculating with floats if approximation is acceptable or BigInt if not.
If you need precise integers and BigInts are too slow then you can use Base.Checked or SaferIntegers.jl, these will throw exceptions on overflow.

You can make most of the examples below throw an exception on overflow by defining a new function `checked_prod` and using it instead of `prod`:

```julia
checked_prod(itr) = reduce(Base.Checked.checked_mul, itr; init=1)
```

Surprisingly, code using checked integer arithmetic can sometimes be faster than unchecked (default) integer arithmetic.

Similarly, if you want to try using big integers or floats:

```julia
big_prod(itr) = reduce(*, itr, init=big(1))
float64_prod(itr) = reduce(*, itr, init=1.0)
```

## Approach: moving window with a for loop

In this approach we calculate the product for each set of `span` digits in `str` in the for loop and keep a record of the largest product in `best`, which we return once the loop terminates.

```julia
function largest_product(str, span)
    if span == 0
        # The product of the empty set is the multiplicative identity (1)
        return 1
    elseif span ∉ 0:length(str)
        throw(ArgumentError("span must be in the range 0:length(str)"))
    elseif !all(isdigit, str)
        throw(ArgumentError("Non-digit character in str"))
    end

    best = 0
    digits = [parse(Int8, ch) for ch in str]
    for left in 1:(length(digits) - span + 1)
        right = left + span - 1
        best = max(best, prod(view(digits, left:right)))
    end

    return best
end
```

This example uses some techniques or syntax that may be unfamiliar to you:

- `span ∉ 0:length(str)` is equivalent to `!(span in 0:length(str))`. `∉` is the mathematical symbol for "not in" and can be typed at the Julia REPL (and possibly in your editor) as `\notin<tab>`.
- `!all(isdigit, str)` is equivalent to `!all(isdigit(char) for char in str)`. Many functions that accept an iterable collection also have a form `whatever(f, itr)` which will apply the function `f` to every element in `itr`.
- `view(digits, left:right)` lets us refer to part of the array `digits` without copying it. We could write `digits[left:right]`, but that will create a new array with a copy of the values from `digits`, which is slower.


## Approach: moving window with `maximum(f, itr)`

Instead of writing our own `for` loop, we could use the `maximum` function:

```julia
function largest_product(str, span)
    if span == 0
        # The product of the empty set is the multiplicative identity (1)
        return 1
    elseif span ∉ 0:length(str)
        throw(ArgumentError("span must be in the range 0:length(str)"))
    elseif !all(isdigit, str)
        throw(ArgumentError("Non-digit character in str"))
    end

    digits = [parse(Int8, ch) for ch in str]
    return maximum(1:(length(digits) - span + 1)) do left
        right = left + span - 1
        prod(view(digits, left:right))
    end
end
```

We've replaced `for left in 1:(length(digits) - span + 1)` with `maximum(1:(length(digits) - span + 1)) do left`.
You can read more about the `do`-block syntax [here][do-block].

This is not better than using a `for` loop, it's just another way to do it.
There is no performance difference between the two.

Another small variation would be to use `zip` rather than calculating `right` within the loop:

```julia
    indexes = Iterators.zip(1:length(digits)-span+1, span:length(digits)-1)
    return maximum(indexes) do (left, right)
        prod(view(digits, left:right))
    end
```

## Approach: moving window with `maximum(f, itr)` and UTF8/ASCII optimisations

Generic Unicode-aware string processing is quite slow, so this approach shows how we can safely and efficiently treat the input as a stream of bytes while still throwing the appropriate errors even in the presence of non-ASCII characters.

```julia
function largest_product(str, span)
    # Get the UTF8 bytes of the string. We want the bytes because iterating
    # UTF8 by character is expensive, but valid inputs to this function will
    # only be ASCII. We will throw the "Non-digit character in str" error if we
    # receive non-ascii strings.
    #
    # This is a no-op for the CPU if the string is already encoded as UTF8
    # (which String is).
    bytes = transcode(UInt8, str)

    # Error handling and parsing guff
    if span == 0
        # The product of the empty set is the multiplicative identity (1)
        return 1
    elseif span ∉ 0:length(bytes)
        throw(ArgumentError("span must be in the range 0:length(str)"))
    elseif !all(c -> UInt8('0') ≤ c ≤ UInt8('9'), bytes)
        throw(ArgumentError("Non-digit character in str"))
    end

    idxs = Iterators.zip(1:length(bytes)-span+1, span:length(bytes))
    return maximum(idxs) do (left, right)
        # The ASCII values for the characters '0':'9' are in order, so we can
        # subtract the value for '0' from the byte to get the digit as an int.
        prod(x -> x - UInt8('0'), view(bytes, left:right))
    end
end
```

It's neat how these optimisations haven't made the code a complete mess, but it's a bit of a shame that we had to change our code at all!
If we know our strings are ASCII (or we are willing to treat them as ASCII), then we should be able to tell Julia that with the type system and then benefit from faster string operations (particularly iteration). And indeed, we can.

If we could import ScottPJones' Strs.jl package\* then we could get similar performance improvements without writing our own ASCII-related optimisations. Instead, we would change the type of the strings that are passed into `largest_product` from Julia's built-in `String` to Strs.jl's `ASCIIStr` type (e.g. `largest_product(ASCIIStr("23"), 2)`).

\* which you can't in Exercism, our test-runner bots don't allow importing third-party packages.

## Approach: one in, one out

We can usually reverse a multiplication by dividing by the same number, so we can save some work compared to the simpler approach of recalculating the product for each window.

This approach works by calculating the product of the initial window, and then for each subsequent step if the digit we're removing from the window is not 0, we divide by it and then multiply by the digit we're adding. If the digit we're removing is 0, that means the window is currently 0 and we have to recalculate it from scratch.

```julia
function largest_product2(str, span)
    if span == 0
        # The product of the empty set is the multiplicative identity (1)
        return 1
    elseif span ∉ 0:length(str)
        throw(ArgumentError("span must be in the range 0:length(str)"))
    elseif !all(isdigit, str)
        throw(ArgumentError("Non-digit character in str"))
    end

    digits = [parse(Int8, ch) for ch in str]

    best = window = prod(view(digits, 1:span))
    for right in span+1:length(digits)
        left = right - span + 1

        # If possible, recalculate the product of the window with
        # just one divide and one multiplication.
        leaving = digits[left - 1]
        if leaving ≠ 0
            window = (window ÷ leaving) * digits[right]
        else
            window = prod(view(digits, left:right))
        end

        best = max(best, window)
    end

    return best
end
```

Note that this solution uses integer division, `window ÷ leaving`, rather than standard division.
In Julia, the unicode divide symbol means integer division, or you can write `div(window, leaving)`.
With standard division, each of `window` and `best` would sometimes be an Int and sometimes be a Float64, and that kind of uncertainty makes the compiler emit slower code and is confusing (the Julia community calls this kind of problem "type instability").

[do-block]: https://docs.julialang.org/en/v1/manual/functions/#Do-Block-Syntax-for-Function-Arguments
