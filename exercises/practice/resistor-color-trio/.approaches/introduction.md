# Introduction

## Approach: simple

Here's a fairly straightforward solution, one of the simplest that this author could come up with, which is generally a good place to start when trying to solve a problem :)

```julia
function label(colors)
    color_key = ("black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white")
    metric_prefixes = ("", "kilo", "mega", "giga")

    color_idx(i) = findfirst(==(colors[i]), color_key) - 1

    tens = color_idx(1)
    units = color_idx(2)
    exponent = color_idx(3)
    ohms = (10tens + units) * 10^exponent

    power_of_1000 = log10(ohms) ÷ 3
    prefix = metric_prefixes[power_of_1000 + 1]
    mantissa = ohms / 1000^power_of_1000

    # We want to print the mantissa without a trailing .0 if it is an integer.
    # The easiest way to get Julia to do that is to convert it to an Int.
    if isinteger(mantissa)
        mantissa = Int(mantissa)
    end
    return "$mantissa $(prefix)ohms"
end
```

If it's not clear to you, then this version that splits the function into the two steps (parsing the three colors into a number of ohms; and formatting a number of ohms into a string) might help:

```julia
function tricolor_to_ohms(colors)
    color_key = ("black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white")
    color_idx(i) = findfirst(==(colors[i]), color_key) - 1

    tens = color_idx(1)
    units = color_idx(2)
    exponent = color_idx(3)
    return (10tens + units) * 10^exponent
end

function format_ohms(ohms)
    metric_prefixes = ("", "kilo", "mega", "giga")

    power_of_1000 = log10(ohms) ÷ 3
    prefix = metric_prefixes[power_of_1000 + 1]
    mantissa = ohms / 1000^power_of_1000

    # We want to print the mantissa without a trailing .0 if it is an integer.
    # The easiest way to get Julia to do that is to convert it to an Int.
    if isinteger(mantissa)
        mantissa = Int(mantissa)
    end
    return "$mantissa $(prefix)ohms"
end

label(colors) = format_ohms(tricolor_to_ohms(colors))
```

There are a few optimisations we could make.
Here are some I came up with, and I encourage you to take a look!
If you'd like to stretch yourself you might like to try to come up with your own optimisation ideas (possibly prompted by the summaries below) before you read mine.

<details>
<summary>Faster power_of_1000</summary>

`log10(ohms)` is a moderately expensive operation.
We can find `floor(log10(ohms))` with only integer arithmetic like this: `exponent + (tens != 0)`.

</details>

<details>
<summary>Simpler formatting</summary>

String formatting a floating point value is more expensive than formatting an integer.
By observing that we can only ever have outputs with one decimal place, we can do our own formatting quite easily:

```julia
if isinteger(mantissa)
    return "$(Int(mantissa)) $(prefix)ohms"
else
    return "$tens.$units $(prefix)ohms"
end
```

We can probably (I didn't benchmark this) speed up the string formatting by taking advantage of the fact that `tens` and `units` are both within `0:9`:

```julia
if isinteger(mantissa)
    return "$(Int(mantissa)) $(prefix)ohms"
else
    tens_char = '0' + tens
    units_char = '0' + units
    return "$tens_char.$units_char $(prefix)ohms"
end
```
</details>

<details>
<summary>Faster color lookup</summary>

At the moment we're doing a linear search through the `color_key` tuple, which you might think is O(n), but it's O(1) because the size of `color_key` is fixed.
But can we go faster?

### Dict

Another natural way to map a string to an integer is to use a `Dict`, but if we do that then we want to construct the dict just once (rather than on every call to `label`.
The standard way to do that in Julia is to use `const` to define a module-level constant:

```julia
const resistor_colors = ("black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white")
const resistor_color_values = Dict(zip(resistor_colors, 0:9))

function label(colors)
    tens = resistor_color_values[colors[1]]
    # ...
end
```

It turns out using a Dict is about 3x faster at finding the value of a single color than using a linear search, even though the linear search is only over 10 strings!
Let's see if we can go faster...

### Avoiding string comparison

String comparison is a bit slow.
Looking at these strings, it happens to be true that they can be uniquely identified by their first and last characters.

When we can efficiently transform a variable-length string into a constant-sized value like this then we can often generate much faster code.

So you could do something like this:

```julia
function firstlast(s)
    bytes = codeunits(c)
    return UInt16(first(bytes)) << 8 | UInt8(last(bytes))
end

function label(colors)
    color_key = map(firstlast, ("bk", "bn", "rd", "oe", "yw", "gn", "be", "vt", "gy", "we"))
    color_idx(i) = findfirst(==(firstlast(colors[i])), color_key)
    # ...
end
```

This changes the behaviour of our function a little: in our other versions if the user provides an invalid string in `colors` then we will throw an error, but in this version if the invalid string happens to match one of our valid strings after `firstlast` is applied then we will treat it as if it were that valid string.
Whether this is acceptable will depend on your use-case.

You probably noticed that we're back to using a linear search again in this example.
We could make a dict as above, mapping from `firstlast(color) => value` instead of `color => value`, but that will now be slower than the linear search because linear search across ten 16 bit integers is very fast (and, in fact Julia can unroll the call to `findfirst` so that the machine code is ten comparisons with integer literals and a few jumps, which is hard to beat).

### Perfect hash tables

In general, when you know the contents of your dict or hash table in advance it's sometimes practical to construct something called a perfect hash table ([more information on wikipedia](https://en.wikipedia.org/wiki/Perfect_hash_function), and in [this video](https://www.youtube.com/watch?v=DMQ_HcNSOAI)).

The code below introduces:
- a very fast hash function suitable for our purposes, `fxhash1_32` (Julia's built-in `hash(x)` function is much better than FxHash in lots of ways, but it's also slower)
- a perfect hash function using `fxhash1_32` that will map each of the valid values of `firstlast(color)` to a different number in `1:2^12`
- a lookup table of 2^12 (4096) integers
- a function using the perfect hash and the table to find the value corresponding to a given color

As before, we're assuming that the input only contains the 10 valid values for `color`, which simplifies our code and lets us go faster.

This approach is about as fast as the linear search with `firstlast` approach on my machine, but it's quite a lot more complicated and needs a bit more memory (~4KiB more).

```julia
# Fastest hash function I know is FxHash.
# This is an adaptation of it for hashing a single value of less than 32 bits.
fxhash1_32(x) = x * 0x517cc1b;

# The smallest power-of-2 table size to ensure no collisions for this data is
# 2^12. You can get a much smaller table size than this, but using a power of 2
# tablesize means that modulus is much much faster.
#
# Adding 1 because % gives a value in 0:2^12-1, but Julia arrays are
# 1-indexed, so we need an index in 1:2^12.
perfect_hash(c) = fxhash1_32(firstlast(c)) % 2^12 + 1

# Constructing the table. I'm using a `let` to avoid polluting the module-level
# scope with the intermediate values and so that Julia knows they're ephemeral.
# I make the table a Tuple so that Julia can know its size and contents are
# constant.
const table = let
    resistor_colors = ("black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white")
    v = zeros(Int8, 2^12)
    for (val, c) in zip(0:9, resistor_colors)
        v[perfect_hash(c)] = val
    end
    Tuple(v)
end

# The function to call from `label(colors)`
resistor_color_value(color) = table[perfect_hash(color)]
```
</details>
