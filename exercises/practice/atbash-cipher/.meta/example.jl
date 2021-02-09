cipher(input::AbstractString) = map(x->isletter(x) ? Char(219-Int(x)) : x, lowercase(filter(c -> isletter(c) || isnumeric(c), input)))
encode(input::AbstractString) = join(collect((m.match for m = eachmatch(r"(.{1,5})", cipher(input)))), ' ')
decode(input::AbstractString) = cipher(input)

