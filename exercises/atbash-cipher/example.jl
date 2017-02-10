cipher(input::AbstractString) = map(x->isalpha(x)?Char(219-Int(x)):x, lowercase(filter(isalnum, input)))
encode(input::AbstractString) = join(matchall(r"(.{1,5})", cipher(input)), ' ')
decode(input::AbstractString) = cipher(input)

