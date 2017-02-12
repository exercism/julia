ispangram(input::AbstractString) = length(Set(matchall(r"[a-z]", lowercase(input)))) == 26

