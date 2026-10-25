# define the CustomSet type
# The tests create sets with `CustomSet(elements)`, where `elements` is a vector
struct CustomSet
    
end

function Base.isempty(s::CustomSet)
    
end

function Base.in(element, s::CustomSet)
    
end

function Base.issubset(s1::CustomSet, s2::CustomSet)
    
end

function disjoint(s1::CustomSet, s2::CustomSet)
    
end

function Base.:(==)(s1::CustomSet, s2::CustomSet)
    
end

function Base.push!(s::CustomSet, element)
    
end

function Base.intersect!(s1::CustomSet, s2::CustomSet)
    
end

function Base.intersect(s1::CustomSet, s2::CustomSet)
    
end

function complement!(s1::CustomSet, s2::CustomSet)
    
end

function complement(s1::CustomSet, s2::CustomSet)
    
end

function Base.union!(s1::CustomSet, s2::CustomSet)
    
end

function Base.union(s1::CustomSet, s2::CustomSet)
    
end
