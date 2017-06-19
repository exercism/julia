function luhn(id::AbstractString)
    id = split(replace(id, ' ', ""), "")
    length(id) < 2 && return false
    all(all(isdigit, s) for s in id) || return false

    numbers = Int[]
    for val in id
        push!(numbers, parse(Int, val))
    end

    for i in length(numbers) - 1:-2:1
        numbers[i] = (numbers[i] * 2) % 9
    end

    return sum(numbers) % 10 == 0
end
