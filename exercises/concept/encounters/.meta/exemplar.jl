abstract type Pet end

struct Dog <: Pet
    name::AbstractString
end

struct Cat <: Pet
    name::AbstractString
end

"""
    encounter(a, b)

Simulate an encounter between `a` and `b`.
"""
encounter(a, b) = "$(name(a)) meets $(name(b)) and $(meets(a, b))."

"""
    name(p::Pet)

Return the name of the pet `p`.
"""
name(p::Pet) = p.name

# fallbacks
meets(a::Pet, b::Pet) = "is cautious"
meets(a::Pet, b) = "runs away"

"""
    meets(a, b)

Return a string describing what happens when `a` and `b` meet.
"""
meets(a, b) = "nothing happens"

# specific types
meets(a::Dog, b::Dog) = "sniffs"
meets(a::Dog, b::Cat) = "chases"
meets(a::Cat, b::Dog) = "hisses"
meets(a::Cat, b::Cat) = "slinks"
