abstract type Pet end

struct Dog <: Pet
    name::AbstractString
end

struct Cat <: Pet
    name::AbstractString
end

encounter(a::Pet, b::Pet) = "$(a.name) meets $(b.name) and $(meets(a, b))."

# generic fallback
meets(a::Pet, b::Pet) = "is confused"

# specific types
meets(a::Dog, b::Dog) = "sniffs"
meets(a::Dog, b::Cat) = "chases"
meets(a::Cat, b::Dog) = "hisses"
meets(a::Cat, b::Cat) = "slinks"
