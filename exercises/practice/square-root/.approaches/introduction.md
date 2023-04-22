# Introduction

## Approach: Heron's method

Perhaps the simplest algorithm for finding the square root of a number is Heron's method, also known as the Babylonian method or Newton's method.
We make an initial guess of what the square root is and then repeatedly calculate `x_next = (S/x + x) / 2`, which is the average of `S/x` and `x`.
Each successive value of `x` will be closer to the real square root.

```julia
function square_root(S)
    S < 1 && throw(DomainError(S, "S must be ≥ 1"))
    x = S
    while (S/x + x) / 2 ≠ x
        x = (S/x + x) / 2
    end
    return x
end
```

If you try to follow this algorithm by hand then it won't necessarily terminate (e.g. √2 has an infinitely long decimal representation), so you'd have to decide when to stop (perhaps after 5 decimal places or something).
Fortunately, we're calculating on a computer and `Float64` has finite precision, so our algorithm will always converge on something.

You can speed this algorithm up quite a bit by making a better initial guess for the square root of S (in the version above we guess that the square root of S is S, which is usually an overestimate!).

Here's one way of estimating the square root:

```julia
function sqrt_approx(S)
    S < 1 && throw(DomainError(S, "S must be ≥ 1"))
    # √S ≈ (0.5 + 0.5a) * 2^(n/2)
    # where S = a * 2^n; and 0.5 ≤ a < 2

    # `& ~1` ensures that `n` is even, which means we can safely half it later.
    n = round(Int, log2(S)) & ~1
    a = S / exp2(n)
    return (0.5 + 0.5a) * exp2(n÷2)
end
```

This is a linear estimation of the square root.

If you know that `S` will be an `Int` of a particular size then you can avoid the moderately expensive call to `log2` by creative use of the `leading_zeros` function.
If you know that `S` will be a float of a particular size then you can extract the exponent (`n`) and significand (`a`) cheaply with some bit-fiddling.
