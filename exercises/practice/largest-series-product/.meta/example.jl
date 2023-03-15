function largest_product(str, span)
    0 <= span <= length(str) || throw(ArgumentError("Span must be ≥ 0 and ≤ length(str)"))
    (iszero(span) || isempty(str)) && return 1

    digits = zeros(Int8, span)
    largest = 0

    for c in str
        isdigit(c) || throw(ArgumentError("String must only contain digits"))
        popfirst!(digits)
        push!(digits, c - '0')
        largest = max(largest, prod(digits))
    end

    largest
end
