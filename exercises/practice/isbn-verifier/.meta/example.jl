import Base: ==, show

struct ISBN{T<:AbstractString}
    s::T

    """
        ISBN(s)

    An International Standard Book Number. Throws `DomainError` if `s` does not look like a valid 10-digit ISBN.
    """
    function ISBN(s)
        acc = 0
        coeff = 10
        for c in s
            if c == '-'
                continue
            elseif isdigit(c)
                # c - '0' is a much faster version of parse(Int, c) when we know c is in '0':'9'.
                acc += (c - '0') * coeff
                coeff -= 1
            # Only the check "digit" is allowed to be 'X' (10)
            elseif c == 'X' && coeff == 1
                acc += 10
                coeff -= 1
            else
                throw(DomainError(s, "'$c' is not allowable at this location"))
            end
        end
        coeff == 0 || throw(DomainError(s, "ISBNs must be 10 digits long"))
        acc % 11 == 0 || throw(DomainError(s, "ISBN checksum failed"))
        # Canonicalise in the simplest way
        s′ = replace(s, '-' => "")
        new{typeof(s′)}(s′)
    end
end

value(x::ISBN) = x.s

==(a::ISBN, b::ISBN) = value(a) == value(b)

macro isbn_str(s) ISBN(s) end

# Show ISBNs as they might appear in your source code if you used the macro.
show(io::IO, isbn::ISBN) = print(io, "isbn\"", value(isbn), '"')
