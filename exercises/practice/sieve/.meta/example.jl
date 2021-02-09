function sieve(limit::Integer)
    limit <= 0 && throw(DomainError(limit, "limit must be strictly positive"))
    nums = fill(true, limit)
    nums[1] = false
    primes = Int[]
    while (i = findfirst(nums)) != nothing
        push!(primes, i)
        for j = findall(nums)
            if j % i == 0
                nums[j] = false
            end
        end
    end
    primes
end
