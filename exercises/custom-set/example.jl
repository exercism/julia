import Base: AbstractSet, isempty, length, in, issubset, iterate,
             push!, ==, copy, intersect!, intersect, union!, union

struct CustomSet{T} <: AbstractSet{T}
    elements::Array{T, 1}
end

isempty(s::CustomSet) = isempty(s.elements)
length(s::CustomSet) = length(s.elements)
in(element, s::CustomSet) = in(element, s.elements)  # this also defines issubset(::CustomSet, ::CustomSet)
copy(s::CustomSet) = CustomSet(copy(s.elements))
push!(s::CustomSet, element) = element in s.elements || push!(s.elements, element)

# Iterator protocol
function iterate(s::CustomSet, state=1)
    if state > length(s)
        return nothing
    end

    s.elements[state], state + 1
end

function disjoint(s1::CustomSet, s2::CustomSet)
    for element in s1
        element in s2 && return false
    end
    return true
end

function complement!(s1::CustomSet, s2::CustomSet)
    for (i, element) in enumerate(s1)
        element in s2 && deleteat!(s1.elements, i)
    end
    return s1
end
complement(s1::CustomSet, s2::CustomSet) = complement!(copy(s1), s2)

function intersect!(s1::CustomSet, s2::CustomSet)
    tbd = Int[]
    for (i, element) in enumerate(s1)
        element in s2 || push!(tbd, i)
    end
    deleteat!(s1.elements, tbd)
    return s1
end
intersect(s1::CustomSet, s2::CustomSet) = intersect!(copy(s1), s2)

function union!(s1::CustomSet, s2::CustomSet)
    for element in s2
        element in s1 || push!(s1, element)
    end
    return s1
end
union(s1::CustomSet, s2::CustomSet) = union!(copy(s1), s2)
