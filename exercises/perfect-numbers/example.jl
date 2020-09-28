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

isnatural(n) = isinteger(n) && n > zero(n)
assert_natural(n) = isnatural(n) || throw(DomainError(n, "n must be a positive integer"))

isabundant(n) = assert_natural(n) && aliquot_sum(n) > n
isperfect(n) = assert_natural(n) && aliquot_sum(n) == n
isdeficient(n) = assert_natural(n) && aliquot_sum(n) < n
