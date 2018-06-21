macro isbn_str(s)
    ISBN(s)
end

struct ISBN <: AbstractString
    s::AbstractString

    ISBN(s) = verify(s) ? new(replace(s, "-", "")) : throw(ArgumentError("invalid ISBN string: $s"))
end

string(s::ISBN) = s.s

function verify(s::AbstractString)
    s = replace(s, "-", "")
    chars = split(s, "")

    length(chars) == 10 || return false

    if last(chars) == "X"
        chars[end] = "10"
    end

    all(c -> all(isdigit, c), chars) || return false

    sum(parse(Int, c) * i for (c, i) in zip(chars, 10:-1:1)) % 11 == 0
end

Base.isvalid(::Type{ISBN}, s::AbstractString) = verify(s)
