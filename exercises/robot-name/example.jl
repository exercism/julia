# http://docs.julialang.org/en/stable/stdlib/numbers/#random-numbers

new_name() = join(map(x->Char(x), rand(65:90, 2))) * repr(rand(100:999))

mutable struct Robot
    name::AbstractString

    Robot() = new(new_name())
end

function reset!(instance::Robot)
    instance.name = new_name()
    instance
end
