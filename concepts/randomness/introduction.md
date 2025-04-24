# Introduction

Many programs need (apparently) random values to simulate real-world events.

Common and familiar examples include:
- A coin toss: a random value from `('H', 'T')`.
- The roll of a die: a random integer from 1 to 6.
- Shuffling a deck of cards: a random ordering of a card list.

Generating truly random values with a computer is a surprisingly difficult technical challenge, so you may see these results referred to as "pseudorandom".

***Important***: This Concept does _not_ cover cryptographically secure random numbers, which are a much more difficult challenge.

However, well-designed libraries like the `Random` module in the Julia standard library are fast, flexible, and give results that are amply good enough for most applications in modelling, simulation and games.

Julia divides random functionality into multiple locations:

- Just a few basic but very versatile functions in `Base`, which are always available.
- A wider range of options in the `Random` module.
- More specialized functionality in packages which need to be installed before use (and are not available in Exercism).

`Random` is part of the standard library and likely to be pre-installed, but you will need to add `using Random` at the top of your program to bring its contents into the namespace.

## The `rand()` function

What this function does depends on the arguments you give it.
There are _many_ options.

With no arguments, it generates a float between 0 and 1.
This is a `uniform` distribution with all values equally likely, as discussed in the Working with Distributions section, below.

A single integer argument generates a vector of that length.

```julia-repl
julia> rand()
0.10261774967264703

julia> rand(5)
5-element Vector{Float64}:
 0.24134501977563894
 0.5664193284851202
 0.9804412082089355
 0.6229551330613335
 0.47589221741904664
```

For a different range, just shift and scale the result appropriately.

The example below uses broadcasting for the subtraction, covered in the Vector Operations Concept.
The `.-` simply applies this arithmetic to each vector element.

```julia-repl
# numbers between -1.0 and +1.0
julia> (rand(5) .- 0.5) * 2
5-element Vector{Float64}:
 -0.5303906759076336
  0.9635682226775855
 -0.048823697086981754
  0.465842804648374
  0.9880834344780736
```

With a type as the only argument, `rand` will use the `typemin` and `typemax` as limits.
This is probably not what you want!

For random integers, we can supply a range, plus optionally how many values to generate.

```julia-repl
julia> rand(Int64)
-9159538335234594326 # not very useful

julia> rand(1:10, 5)
5-element Vector{Int64}:
 1
 1
 1
 4
 7
```

In the `rand(1:10, 5)` example above, notice that there are (coincidentally) repeating values, because each pick is independent.
This is "sampling with replacement", discussed in more detail below.

For floating-point values in a range, you will usually need to specify a step size.
Otherwise the step will default to 1.0, which is rarely useful.

```julia-repl
julia> rand(2.4:0.01:3.2, 4)
4-element Vector{Float64}:
 3.19
 2.53
 3.14
 3.13
```

Alternatively, supply an array or tuple, and `rand` will return a random entry:

```julia-repl
julia> rand([4, 9, 16, 25])
16

# coin flip
julia> rand(['H', 'T'])
'H': ASCII/Unicode U+0048 (category Lu: Letter, uppercase)

# mixed types in tuple
julia> rand( (1, 3.2, "name"), 2 )
2-element Vector{Any}:
 1
  "name"
```

### Sampling with or without replacement

Imagine that we have a bag containing 3 red balls and 4 green balls, and we randomly pull a ball from the bag.
To get a second ball, there are two possibilities:

1. Replace the first ball in the bag and give everything a good shake before pulling out another.
   The number of balls is now the same as before (7), and _the ratio of red to green is also the same_.
2. Put the first ball on the table before pulling out a second.
   Now there are only 6 balls in the bag, and _the red:green ratio depends on the color of the first ball_.

Scenario 1 is with replacement, scenario 2 is without, and _they give different results_.

To simulate sampling without replacement in Julia, there are a couple of options.

Simplest (_and within Exercism the only option_), use `Random.shuffle()` to put the entries in random order, then use the first `n` elements.
This is fine for small problems but may not scale well to large collections: `shuffle` needs to generate the full array, even if you only want a small fraction of it.

To do sampling-with-replacement "properly", install the `StatsBase.jl` package.
That provide the `sample()` function with a full range of options.

We can reasonably hope that similar functionality will be added into `Random` in a future release, to make it part of the standard library (code samples in this document were tested with Julia 1.11).

## Working with Distributions

Until now, we have concentrated on cases where all outcomes are equally likely.
For example, `rand(1:100)` is equally likely to give any integer from 1 to 100.

Many real-world situations are far less simple than this.
As a result, statisticians have created a wide variety of `distributions` to describe "real world" results mathematically.

### Uniform distributions

The `rand()` function described above is used when all probabilities are equal.
This is called a `uniform` distribution.

### Gaussian distribution

Also called the "normal" distribution or the "bell-shaped" curve, this is a very common way to describe imprecision in measured values.

For example, suppose the factory where you work has just bought 10,000 bolts which should be identical.
You want to set up the factory robot to handle them, so you weigh a sample of 100 and find that they have an average (or `mean`) weight of 4.731g.
This is extremely unlikely to mean that they all weigh exactly 4.731g.
Perhaps you find that values range from 4.627 to 4.794g but cluster around 4.731g.

This is the `Gaussian distribution`, for which probabilities peak at the mean and tails off symmetrically on both sides (hence "bell-shaped").
To simulate this in software, we need some way to specify the width of the curve (_typically, expensive bolts will cluster more tightly around the mean than cheap bolts!_).

By convention, this is done with the `standard deviation`: small values for a sharp, narrow curve, large for a low, broad curve.
Mathematicians love Greek letters, so we use `μ` ('mu') to represent the mean and `σ` ('sigma') to represent the standard deviation.
Thus, if you read that "95% of values are within 2σ of μ" or "the Higgs boson has been detected with 5-sigma confidence", such comments relate to the standard deviation.

There will be more to say about this in the `Statistics` Concept.

## The `randn()`function

Short for "random normal", this is similar to the floating-point variant of `rand()` except that values are distributed as a Gaussian with mean 0 and standard deviation 1.

Again, you may want to scale the raw output from `randn` for standard deviation, and displace it for the mean.
The example below converts to mean 30 and StdDev 5.

```julia-repl
julia> raw = randn(5)
5-element Vector{Float64}:
  3.0762588867281475
  1.5101100620253902
 -0.5914858221637778
  0.684175554069735
 -0.8416433926114673

julia> raw * 5 .+ 30
5-element Vector{Float64}:
 45.38129443364074
 37.55055031012695
 27.04257088918111
 33.420877770348675
 25.791783036942665
```

It is hard to tell from looking at the output that the raw output clusters closer to zero than for a uniform distribution.
If you doubt it, generate 1000 or more and plot them to make it more obvious.

## The `Random` module

This module contains the next tier of functionality, omitted from `Base` to help minimize the size of Julia's default configuration.

`Random` supplements `rand` and `randn` in `Base` with mutating versions, `rand!` and `randn!`.

A useful addition is `randstring`, which generates a string of given length.
By default, this uses upper- and lowercase letters plus digits 0 to 9, but other choices can be specified.

```julia-repl
julia> using Random

julia> randstring(20)
"BoJnIxrS33pJiWggXZQV"
```

Additionally, there is a `bitrand` function to generate a random `BitArray` of specified length.

```julia-repl
julia> bitrand(5)
julia> bitrand(5)
5-element BitVector:
 1
 1
 0
 0
 1
```

### Shuffles and permutations

To randomly shuffle entries in a `Vector` we have `shuffle`; also `shuffle!` to mutate the input vector in-place.

```julia-repl
julia> v = ['A', '1', '2', 'J', 'Q', 'K'];

julia> shuffle(v)
6-element Vector{Char}:
 'K': ASCII/Unicode U+004B (category Lu: Letter, uppercase)
 '1': ASCII/Unicode U+0031 (category Nd: Number, decimal digit)
 'A': ASCII/Unicode U+0041 (category Lu: Letter, uppercase)
 'J': ASCII/Unicode U+004A (category Lu: Letter, uppercase)
 '2': ASCII/Unicode U+0032 (category Nd: Number, decimal digit)
 'Q': ASCII/Unicode U+0051 (category Lu: Letter, uppercase)

# shuffles are random:
julia> shuffle(v)
6-element Vector{Char}:
 '2': ASCII/Unicode U+0032 (category Nd: Number, decimal digit)
 'K': ASCII/Unicode U+004B (category Lu: Letter, uppercase)
 'A': ASCII/Unicode U+0041 (category Lu: Letter, uppercase)
 'Q': ASCII/Unicode U+0051 (category Lu: Letter, uppercase)
 'J': ASCII/Unicode U+004A (category Lu: Letter, uppercase)
 '1': ASCII/Unicode U+0031 (category Nd: Number, decimal digit)
```

Sometimes it is useful to have the shuffled indices instead.
For this, use `randperm(n)` where n is the length of the sequence.

```julia-repl
julia> randperm(6)
6-element Vector{Int64}:
 6
 2
 4
 1
 3
 5
```

In effect, the example above gives the same results as `shuffle(1:6)`.
