function distance(s1, s2)
    length(s1) != length(s2) && throw(ArgumentError("Sequences must have the same length"))
    count(a != b for (a, b) in zip(s1, s2))
end
