ispangram(input::AbstractString) = length(Set(collect((m.match for m = eachmatch(r"[a-z]", lowercase(input)))))) == 26
