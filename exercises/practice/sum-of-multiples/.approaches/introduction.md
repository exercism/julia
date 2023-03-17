# Introduction

## General guidance

The list of factors can include 0. There are of course infinite multiples of zero less than the limit, but they all sum to 0, so we would not like to count them. You can filter the zeros within your loops (as shown in the approaches below), or you can filter them from `factors` in advance like this:

```julia
# There are infinite multiples of 0 within any limit, but they all sum to
# 0, so remove them.
factors = filter(≠(0), factors)
```

## Approach: summing a set

In this approach we find every multiple less than the limit for each factor. We add them all to a `Set` to remove duplicates and then sum the set.

```julia
function sum_of_multiples(limit, factors)
    multiples = Set{Int}()
    for f in factors
        f == 0 && continue
        multiple = f
        while multiple < limit
            push!(multiples, multiple)
            multiple += f
        end
    end
    sum(multiples)
end
```

We specify that the `Set` will contain `Int` by writing `Set{Int}`. This is necessary so that `sum` knows how to sum the empty set (an empty set of integers has a sum of 0, but if the set has an unknown type then we cannot know it's sum).

We could also have used a `BitSet` here instead of a `Set`, which is the better option when working with a dense set of integers.
To use a `BitSet` replace `Set{Int}()` on line 2 with `BitSet()`,
but beware that `BitSet`s can use an enormous about of memory if the difference between the smallest and largest element is very large, which can happen in this function if the limit is very large.

<details>
<summary>Automatically choosing between a `BitSet` and a `Set{Int}`</summary>

We can automatically choose between a `BitSet` and a `Set` with a function like this:

```julia
function sum_of_multiples(limit, factors)
    sum(unique_multiples(limit, factors))
end

"""
    unique_multiples(limit, factors)

The unique multiples of factors ≤ limit.

!!! warning "Type instability!"

    This function can return a BitSet or a Set{Int}(), you may want to check
    that this instability isn't a performace or correctness problem for your
    usecase.
"""
function unique_multiples(limit, factors)
    # BitSets can be unreasonably large, so we use a BitSet only if it will be
    # less than 5MiB in size (arbitrary limit) or if a Set would be even bigger
    smallest_factor = minimum(factors)
    max_sparse_bitset_size = 5 * 1024^2 * 8 # (in bits)
    # both very approximate
    approx_bitset_size = limit - smallest_factor
    approx_set_size = (limit ÷ smallest_factor) * 72
    use_bitset =  approx_bitset_size < max_sparse_bitset_size ||
                  approx_bitset_size < approx_set_size

    multiples = if use_bitset
        BitSet()
    else
        Set{Int}()
    end

    for f in factors
        f == 0 && continue
        multiple = f
        while multiple < limit
            push!(multiples, multiple)
            multiple += f
        end
    end

    return multiples
end
```

I came up with the approximations for the sizes of each collection by making a few collections and inspecting them with `dump()`.

I chose the 5[MiB][mebibyte] cut-off before this function considers using a `Set{Int}` arbitrarily.
If you wanted to, you could do some benchmarks and find a better cut-off.

I noted the type instability in the docstring of `unique_multiples`, but in this case Julia's [union-splitting optimisations][union-splitting] mean that our code will still end up fast.
It will compile to something similar to:

```julia
function sum_of_multiples(limit, factors)
    multiples = unique_multiples(limit, factors)
    if multiples isa BitSet
        sum(multiples::BitSet)
    else
        sum(multiples::Set{Int})
    end
end
```

If the body of `sum_of_multiples` was more complicated (as in the Wheel approach below), then the type instability could cause performance issues.
In that case, performance could be improved be coercing `multiples` into just one type (e.g. `collect(unique_multiples(limit, factor))` to turn it into a vector), or by introducing a "function barrier", or by writing explicit ifs (`if multiples isa BitSet`).

If this seems a bit clumsy to you, another approach would be to write your own set implementation (possibly using `BitSet` and `Set`) that has good performance for both dense and sparse sets of integers.
This is left as an exercise for the reader ;)

</details>


## Approach: finding remainders

Another option is to test every integer between 1 and (limit - 1) to see if it's divisible by any of our factors:

```julia
function sum_of_multiples(limit, factors)
    acc = 0
    for x in 1:limit-1
        for f in factors
            if f ≠ 0 && x % f == 0
                acc += x
                break
            end
        end
    end
    acc
end
```

We can reduce that to one line like so:

```julia
function sum_of_multiples(limit, factors)
    sum(x for x in 1:limit-1 if any(x % f == 0 for f in factors if f ≠ 0))
end
```

How does this approach compare to "Approach: summing a set"? Do you think it is more or less understandable? Is it likely to be faster or slower, and if so, for what kinds of inputs do you think it will be faster/slower and why?

<details>
<summary>Answer</summary>

Understandability is a matter of opinion and taste, but for me both approaches are understandable.

As for performance, finding the remainders will almost always be a lot slower because it is performing many more iterations of its inner loop (at least once for each of 1:limit-1) and its inner loop is more expensive (CPUs take several times longer to divide integers than to add them).

When benchmarking, finding the remainders was only faster when when the factors started at 1 (so every value in 1:limit-1 is a factor) or there were an enormous number of repeated factors, which are the worst cases for the summing set approach but are also quite silly inputs. Try the benchmarking code below if you're interested in running your own experiments.

```julia
function sum_of_multiples1(limit, factors)
    multiples = BitSet()
    for f in factors
        f == 0 && continue
        multiple = f
        while multiple < limit
            push!(multiples, multiple)
            multiple += f
        end
    end
    sum(multiples)
end

function sum_of_multiples2(limit, factors)
    sum(x for x in 1:limit-1 if any(x % f == 0 for f in factors if f ≠ 0))
end

using BenchmarkTools

@benchmark sum_of_multiples1(100_000, 2:100) # 700μs
@benchmark sum_of_multiples2(100_000, 2:100) # 7ms (10x slower)

@benchmark sum_of_multiples1(100_000_000, 2:100) # 800ms
@benchmark sum_of_multiples2(100_000_000, 2:100) # 7s (9x slower)

@benchmark sum_of_multiples1(100_000, 1:100) # 900μs
@benchmark sum_of_multiples2(100_000, 1:100) # 500μs (1.8x faster)
```

</details>

## Approach: using a wheel

You can also solve this exercise using a technique inspired by [wheel factorisation][wheel].
This solution by cmcaine relies on the observation that the multiples of the factors are a sequence that repeats modulo the product of the factors.
We can then add the entire cycle + offsets to the sum with two additions and a multiplication rather than adding each multiple one at a time.
This solution can be hundreds or thousands of times faster than "Approach: summing a set" when the product of the factors is smaller than the limit and is at worst the same speed as "Approach: summing a set".

The downside, of course, is that this approach is a lot more complicated.

```julia
# Implementation inspired by wheel factorisation.
# We observe that the multiples of the factors is a sequence that repeats with an offset.
# We call the repeating values the `cycle` and the offset is the
# wheel_circumference times the number of cycles we have completed so far.
#
# Finding the the repeating sequence lets us add the sum of the whole sequence
# plus offsets on each iteration, rather than adding each individual value,
# which can make this function much faster than simpler solutions.
function sum_of_multiples(limit, factors)
    factors = filter(≠(0), factors)
    isempty(factors) && return 0

    # Warning! This can easily and silently overflow and cause us to emit
    # garbage or loop forever.
    wheel_circumference = prod(factors)
    cycle_limit = min(limit, wheel_circumference + minimum(factors))

    # BitSets are ordered and of course contain only unique values.
    # We rely on both properties below.
    cycle = BitSet()
    for f in factors
        m = f
        while m < cycle_limit
            push!(cycle, m)
            m += f
        end
    end
    cycle_sum = sum(cycle)
    # If we're already at the limit, then we're done
    cycle_limit == limit && return cycle_sum
    # Otherwise use the fast wheel-factorisation approach

    # Add complete cycles + offsets to the accumulator
    acc = 0
    cycles = 0
    cycle_len = length(cycle)
    cycle_max = last(cycle)
    while cycle_max + wheel_circumference * cycles < limit
        acc += cycle_sum + cycle_len * wheel_circumference * cycles
        cycles += 1
    end

    # Add the partial last cycle + offset to the accumulator
    final_offset = wheel_circumference * cycles
    for m in cycle
        m + final_offset < limit || break
        acc += m + final_offset
    end

    return acc
end
```

Because this function calculates the product of the factors it is even more liable to suffer from integer overflow than the other approaches on this page (and all of them can experience overflow).
Here's one way of calculating `wheel_circumference` that handles overflow:

```julia
    # The circumference of the wheel is the product of the factors, which means
    # it can quickly become far too large. We can't just calculate the product
    # with `prod` because if the factors are Ints then we can get silent
    # overflow issues, so instead we're calculating the product with checked
    # arithmetic.
    wheel_circumference = try
        reduce(Base.Checked.checked_mul, factors, init=1)
    catch e
        if e isa OverflowError
            # Set wheel_circumference to the limit if the real value is way too
            # big. This means we will fall-back to the non-wheel method for
            # finding the answer.
            limit
        else
            rethrow()
        end
    end
```

There are several other additions and multiplications in this approach and the others that can overflow if the limit or factors are too large.
You can use `checked_add` and `checked_mul` from `Base.Checked` to make your code throw an error if there's overflow.
Another approach would be to edit your code to support different types of numbers (all of the examples so far expect `Int`), and then callers can use Floats or BigInts or SaferIntegers if their limits or factors are large.

Overflow can be quite tricky!
If you're worried about it you might like to look at the SaferIntegers.jl package or just do your numeric programming with Float64s; BigInt; or BigFloat.

[mebibyte]: https://simple.wikipedia.org/wiki/Mebibyte
[wheel]: https://en.wikipedia.org/wiki/Wheel_factorization
[union-splitting]: https://julialang.org/blog/2018/08/union-splitting/
