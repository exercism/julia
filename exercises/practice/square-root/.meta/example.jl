function square_root(n::Int64)
    if n ≤ 0
        throw(DomainError(n, "Can only calculate roots of natural numbers."))
    end
    x = initial_guess(n)
    while x ≠ 0.5 * (x + n / x)
        x = 0.5 * (x + n / x)
    end
    x
end


function initial_guess(n::Int64)
    m = floor(Int, log10(n) / 2)
    a = n ÷ (10 ^ m)
    (a < 10 ? (0.89 + 0.28*a) : (2.8 + 0.089*a)) * 10^m
end