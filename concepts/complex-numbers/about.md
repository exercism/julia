# About

`Complex numbers` are not complicated.
They just need a less alarming name.

They are so useful, especially in engineering and science, that Julia includes [complex numbers][complex] as standard numeric types alongside integers and floating-point numbers.

## Basics

A `complex` value in Julia is essentially a pair of numbers: usually but not always floating-point.
These are called the "real" and "imaginary" parts, for unfortunate historical reasons.
Again, it is best to focus on the underlying simplicity and not the strange names.

To create complex numbers from two real numbers, just add the suffix `im` to the imaginary part.

```julia-repl
julia> z = 1.2 + 3.4im
1.2 + 3.4im

julia> typeof(z)
ComplexF64 (alias for Complex{Float64})

julia> zi = 1 + 2im
1 + 2im

julia> typeof(zi)
Complex{Int64}
```

Thus there are various `Complex` types, derived from the corresponding integer or floating-point type.

To create a complex number from real variables, the above syntax will not work.
Writing `a + bim` confuses the parser into thinking `bim` is a (non-existent) variable name.

Writing `b*im` is possible, but the preferred method uses the `complex()` function.

```julia-repl
julia> a = 1.2; b = 3.4; complex(a, b)
1.2 + 3.4im
```

You may wonder, why `im` rather than `i` or `j`?

Most engineers are happy with `j`.
Most scientists and mathematicians prefer the mathematical notation `i` for _imaginary_, but that notation conflicts with the use of `i` to mean _current_ in Electrical Engineering.

The [manual][complex] states that "Using mathematicians' i or engineers' j for this global constant was rejected since they are such popular index variable names".

By happy coincidence, this also avoids long arguments between engineers and everyone else.
Feel free to form your own judgement about whether this influenced the decision.

To access the parts of a complex number individually:

```julia-repl
julia> z = 1.2 + 3.4im
1.2 + 3.4im

julia> real(z)
1.2

julia> imag(z)
3.4
```

Either part can be zero and mathematicians may then talk of the number being "wholly real" or "wholly imaginary".
However, it is still a complex number in Julia.

```julia-repl
julia> zr = 1.2 + 0im
1.2 + 0.0im

julia> typeof(zr)
ComplexF64 (alias for Complex{Float64})

julia> zi = 3.4im
0.0 + 3.4im

julia> typeof(zi)
ComplexF64 (alias for Complex{Float64})
```

You may have heard that "`i` (or `j`) is the square root of -1".

For now, all this means is that the imaginary part _by definition_ satisfies the following equality:

```julia-repl
julia> 1im * 1im == -1
true
```

This is a simple idea, but it leads to interesting consequences.

## Arithmetic

All of the standard mathematical `operators` and elementary functions used with floats and integers also work with complex numbers. A small sample:

```julia-repl
julia> z1 = 1.5 + 2im
1.5 + 2.0im

julia> z2 = 2 + 1.5im
2.0 + 1.5im

julia> z1 + z2  # addition
3.5 + 3.5im

julia> z1 * z2  # multiplication
0.0 + 6.25im

julia> z1 / z2  # division
0.96 + 0.28im

julia> z1^2  # exponentiation
-1.75 + 6.0im

julia> 2^z1  # another exponentiation
0.5188946835878313 + 2.7804223253571183im
```

Explaining the rules for complex number multiplication and division is out of scope for this concept (_and you are unlikely to have to perform those operations "by hand" very often_).

Any [mathematical][math-complex] or [electrical engineering][engineering-complex] introduction to complex numbers will cover this, should you want to dig into the topic.

Alternatively, Exercism has a `Complex Numbers` practice exercise where you can implement a complex number class with these operations from first principles.

Integer division is (mostly) ___not___ possible on complex numbers, so the `//`, `÷` and `%` operators will fail for the complex number type.
An exception is using `//` with complex _integers_ to get complex rational numbers, but this is probably not often useful.

## Functions

Most mathematical functions will work with complex inputs.

However, providing real inputs and expecting a complex output will not usually work.
This is a performance optimization that should make more sense after looking at the Multiple Dispatch concept.

```julia-repl
julia> sin(1.5 + 2.0im)
3.752771340479298 + 0.25655395609048176im

julia> sqrt(-1)
ERROR: DomainError with -1.0:
sqrt was called with a negative real argument but will only return a complex result if called with a complex argument. Try sqrt(Complex(x)).

julia> sqrt(-1 + 0im)
0.0 + 1.0im
```

There are several functions, in addition to `real()` and `imag()`, with particular relevance for complex numbers.
Please skip over these if they make no sense to you!

- `conj()` simply flips the sign of the imaginary part of a complex number (_from + to - or vice-versa_).
    - Because of the way complex multiplication works, this is more useful than you might think.
- `abs(<complex number>)` is guaranteed to return a real number with no imaginary part.
- `abs2(<complex number>)` returns the square of `abs(<complex number>)`: quicker to calculate than `abs()`, and often what a calculation needs.
- `angle(<complex number>)` returns the phase angle in radians.

```julia-repl
julia> z1
1.5 + 2.0im

julia> conj(z1)
1.5 - 2.0im

julia> abs(z1)
2.5

julia> abs2(z1)
6.25

julia> angle(z1)
0.9272952180016122
```
A partial explanation, for the mathematically-minded _(again, feel free to skip)_:

- The `(real, imag)` representation of `z1` in effect uses Cartesian coordinates on the complex plane.
- The same complex number can be represented in `(r, θ)` notation, using polar coordinates.
- Here, `r` and `θ` are given by `abs(z1)` and `angle(z1)` respectively.

Here is an example using some constants:

```julia-repl
julia> euler = exp(1im * π)
-1.0 + 1.2246467991473532e-16im

julia> real(euler)
-1.0

julia> round(imag(euler), digits=15)  # round to 15 decimal places
0.0
```

So a simple expression with three of the most important constants in nature `e`, `i` (or `j`) and `pi` gives the result `-1`.
Some people believe this is the most beautiful result in all of mathematics.
It dates back to around 1740.

The polar `(r, θ)` notation is so useful, that there are built-in functions `cis` (short for cos(x) + isin(x)) and `cispi` (short for cos(πx) + isin(πx)) which can help in constructing it more efficiently.

```julia-repl
julia> exp(1im * π) ≈ cis(π) ≈ cispi(1)
true
```

The approximate equality above is because the functions [`cis`][cis] and [`cispi`][cispi] can give nicer numerical outputs, with `cispi` in particular when dealing with arguments that are arbitrary factors of π (e.g. radians!).

```julia-repl
julia> cis(π)
-1.0 + 0.0im

julia> cispi(1)
-1.0 + 0.0im

julia> θ = π/2;
julia> exp(im*θ)
6.123233995736766e-17 + 1.0im

julia> cis(θ)
6.123233995736766e-17 + 1.0im

julia> cispi(θ / π)  # θ/π == 1/2
0.0 + 1.0im
```

-----

## Optional section: a Complex Numbers FAQ

This part can be skipped, unless you are interested.

### Isn't this some strange new piece of pure mathematics?

It was strange and new in the 16th century.

500 years later, it is central to most of engineering and the physical sciences.

### Why would anyone use these?

It turns out that complex numbers are the simplest way to describe anything that rotates or anything with a wave-like property.
So they are used widely in electrical engineering, audio processing, physics, computer gaming, and navigation - to name only a few applications.

You can see things rotate.
Complex numbers may not make the world go round, but they are great for explaining _what happens_ as a result of the world going round: look at any satellite image of a major storm.

Less obviously, sound is wave-like, light is wave-like, radio signals are wave-like, and even the economy of your home country is at least partly wave-like.

A lot of this wave processing can be done with trig functions (`sin()` and `cos()`) but that gets messy quite quickly.

Complex exponentials are ___much___ easier to work with.

### But I don't need complex numbers!

Only true if you are living in a cave and foraging for your food.

If you are reading this on any sort of screen, you are utterly dependent on some useful 20th-Century advances made through the use of complex numbers.

1. __Semiconductor chips__.
    - These make no sense in classical physics and can only be explained (and designed) by quantum mechanics (QM).
    - In QM, everything is complex-valued by definition. (_it's waveforms all the way down_)

2. __The Fast Fourier Transform algorithm__.
    - FFT is an application of complex numbers, and it is in _everything_ connected to sound transmission, audio processing, photos, and video.

    - MP3 and other audio formats use FFT for compression, ensuring more audio can fit within a smaller storage space.
    - JPEG compression and MP4 video, among many other image and video formats, also use FFT for compression.

    - FFT is also deployed in the digital filters that allow cellphone towers to separate your personal cell signal from everyone else's.

So, you are probably using technology that relies on complex number calculations thousands of times per second.


[complex]: https://docs.julialang.org/en/v1/manual/complex-and-rational-numbers/#Complex-Numbers
[math-complex]: https://www.nagwa.com/en/videos/143121736364/
[engineering-complex]: https://www.khanacademy.org/science/electrical-engineering/ee-circuit-analysis-topic/ee-ac-analysis/v/ee-complex-numbers
[operators]: https://docs.julialang.org/en/v1/manual/mathematical-operations/#Arithmetic-Operators
[cis]: https://docs.julialang.org/en/v1/base/math/#Base.cis
[cispi]: https://docs.julialang.org/en/v1/base/math/#Base.cispi
