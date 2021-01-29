# Implement number base conversion

function all_your_base(digits, input_base, output_base)
    # error checking behavior
    if input_base < 2
        throw(DomainError(input_base, "input base must be >= 2"))
    end

    if output_base < 2
        throw(DomainError(output_base, "output base must be >= 2"))
    end

    # short-circuit for [0] input; doesn't matter the base
    if isempty(digits)
        return [0]
    end

    # encode the list to a single number
    total = 0
    for i in digits
        if i >= input_base || i < 0
            throw(DomainError(input_base, "all digits must satisfy 0 <= d < input base"))
        end
        total = total * input_base + i
    end

    # decode to desired base
    output = Int[]
    while total > 0
        (total, rem) = divrem(total, output_base)
        push!(output, rem)
    end

    if isempty(output)
        return [0]
    end

    return reverse!(output)
end
