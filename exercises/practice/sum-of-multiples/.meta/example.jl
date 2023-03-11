function sum_of_multiples(limit, multiples)
    uniques = Set([0])
    for num in [m for m in multiples if m > 0]
        mult = num
        while mult < limit
            push!(uniques, mult)
            mult += num
        end
    end
    return sum(uniques)
end