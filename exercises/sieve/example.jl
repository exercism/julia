function sieve(limit::Integer)
    limit <= 0 && error("Invalid limit")
    nums = fill(true, limit)
    nums[1] = false
    primes = []
    while (i = findfirst(nums)) > 0
        push!(primes, i)
        for j = findall(nums)
            if j % i == 0
                nums[j] = false
            end
        end
    end
    primes
end
