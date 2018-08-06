function distance(s1::AbstractString, s2::AbstractString)
    length(s1) != length(s2) && throw(ArgumentError("Sequences must have the same length"))
    reduce(+, a != b for (a, b) in zip(s1, s2); init=0)
end
