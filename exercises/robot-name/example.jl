# Scott P Jones' solution as reinterpreted by Colin Caine

using Random: shuffle!

# Use Int32 to save some bits because this is quite a big vector.
const names = shuffle!(Int32[0:26^2 * 10^3 - 1;])

mutable struct Robot
    # Robots are comfortable with integer names ;)
    id::Int32
    Robot() = new(mint_id())
end

function mint_id()
    isempty(names) ? error("No unique identifiers left!") : pop!(names)
end

"Convert an integer name to a human-friendly name"
function id2name(id)
    id, c1 = divrem(id, 26)
    id, c2 = divrem(id, 26)
    id, d1 = divrem(id, 10)
    id, d2 = divrem(id, 10)
    d3 = id
    return join((Char('A' + c1),
                 Char('A' + c2),
                 string.((d1, d2, d3))...))
end

function reset!(instance::Robot)
    instance.id = mint_name()
    instance
end

function name(instance::Robot)
    id2name(robot.id)
end
