# Scott P Jones' solution as reinterpreted by Colin Caine

using Random: shuffle!

# Use Int32 to save some bits because this is quite a big vector.
const names = shuffle!(Int32[0:26^2 * 10^3 - 1;])

mutable struct Robot
    # Robots are comfortable with integer names ;)
    id::Int32

    """
        Robot()

    Construct a robot with a unique name within its class.
    """
    Robot() = new(mint_id())
end


"""
    mint_id()

Return a unique robot id. If there are none left, error.
"""
function mint_id()
    isempty(names) ? error("No unique identifiers left!") : pop!(names)
end


"""
    id2name(id)

Convert an integer name to a human-friendly name.
"""
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


"""
    reset!(instance::Robot)

Factory-reset this robot, assigning it a new unique name.
"""
function reset!(instance::Robot)
    instance.id = mint_id()
    instance
end


"""
    name(instance::Robot)

Return this robot's name.
"""
function name(instance::Robot)
    id2name(instance.id)
end
