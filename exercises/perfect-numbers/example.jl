function aliquot_sum(n)
    if !isinteger(n) || n < 0
        throw(DomainError(n,"n must be a non-negative integer"))
    # In Julia <1.4, you need this special case because `sum` doesn't like
    # empty collections
    elseif n <= 1
        return 0
    end
    return sum(i for i in 1:div(n, 2) if n % i == 0)
end

function classify(n)
    if !isinteger(n) || n < 1
        throw(DomainError(n, "n must be a positive integer"))
    end
    s = aliquot_sum(n)
    if s > n
        :abundant
    elseif s < n
        :deficient
    else
        :perfect
    end
end
