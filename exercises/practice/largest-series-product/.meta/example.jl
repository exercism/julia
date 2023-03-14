function largest_product(s, span)
    0 <= span <= length(s) || throw(DomainError(span, "Span must be ≥ 0 and ≤ length(s)"))
    (iszero(span) || isempty(s)) && return 1

    digits = zeros(Int8, span)
    largest = 0

    for c in s
        isdigit(c) || throw(DomainError(s, "String must only contain digits"))
        popfirst!(digits)
        push!(digits, c - '0')
        largest = max(largest, prod(digits))
    end

    largest
end
