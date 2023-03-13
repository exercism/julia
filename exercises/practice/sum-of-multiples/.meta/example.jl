function sum_of_multiples(limit, factors)
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
