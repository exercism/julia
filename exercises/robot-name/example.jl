# http://docs.julialang.org/en/stable/stdlib/numbers/#random-numbers

name_history = String[]

function new_name()
    generate_name() = join(map(x->Char(x), rand(65:90, 2))) * repr(rand(100:999))
    name = generate_name()
    while name in name_history
        name = generate_name()
    end
    push!(name_history, name)
    name
end

mutable struct Robot
    name::AbstractString

    Robot() = new(new_name())
end

function reset!(instance::Robot)
    instance.name = new_name()
    instance
end
