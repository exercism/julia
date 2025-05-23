abstract type Pet end

struct Dog <: Pet
    name::AbstractString
end

struct Cat <: Pet
    name::AbstractString
end

name(p::Pet) = p.name

# specific types
meets(a::Dog, b::Dog) = "sniffs"
meets(a::Dog, b::Cat) = "chases"
meets(a::Cat, b::Dog) = "hisses"
meets(a::Cat, b::Cat) = "slinks"

encounter(a, b) = "$(name(a)) meets $(name(b)) and $(meets(a, b))."

# fallbacks
meets(a::Pet, b::Pet) = "is cautious"
meets(a::Pet, b) = "runs away"
meets(a, b) = "nothing happens"
