function keep(values, predicate)
    results = []
    for value in values
        if predicate(value)
            push!(results, value)
        end
    end

    results
end

function discard(values, predicate)
    keep(values, x -> !predicate(x))
end
