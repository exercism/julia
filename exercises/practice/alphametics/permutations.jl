# Extract of Combinatorics.jl
#
# License:
#
#    Copyright (c) 2013-2015: Alessandro Andrioni, Jiahao Chen and other
#    contributors.
#
#    Permission is hereby granted, free of charge, to any person obtaining a
#    copy of this software and associated documentation files (the "Software"),
#    to deal in the Software without restriction, including without limitation
#    the rights to use, copy, modify, merge, publish, distribute, sublicense,
#    and/or sell copies of the Software, and to permit persons to whom the
#    Software is furnished to do so, subject to the following conditions:
#
#    The above copyright notice and this permission notice shall be included in
#    all copies or substantial portions of the Software.
#
#    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
#    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
#    DEALINGS IN THE SOFTWARE.

# Combinatorics/src/permutations.jl

struct Permutations{T}
    data::T
    permlen::Int
    function Permutations{T}(a, t::Integer) where T<:Vector
        if t < 0
            t = length(a) + 1
        end
        data = sizehint!(eltype(T)[], length(a))
        foreach(i -> push!(data, a[i]), eachindex(a))
        new{T}(data, t)
    end
end

Base.eltype(::Type{Permutations{T}}) where T = T

function Base.length(p::Permutations)
    length(p.data) < p.permlen && return 0
    return Int(prod(length(p.data) - p.permlen + 1:length(p.data)))
end

"""
    permutations(data)
Generate all permutations of an indexable object `data` in index-based lexicographic order. 
Because the number of permutations can be very large, this function returns an iterator object.
Use `collect(permutations(data))` to get an array of all permutations.
"""
permutations(data) = permutations(data, length(data))

"""
    permutations(data, permlen)
Generate all size `permlen` permutations of an indexable object `data` in index-based lexicographic order.
Because the number of permutations can be very large, this function returns an iterator object.
Use `collect(permutations(data))` to get an array of all permutations.
"""
permutations(data, permlen::Integer) = Permutations{Vector{eltype(data)}}(data, permlen)

function Base.iterate(p::Permutations, state::Vector{Int} = collect(eachindex(p.data)))
    (!isempty(state) && max(state[1], p.permlen) > length(p.data) || (isempty(state) && p.permlen > 0)) && return nothing
    nextpermutation!(p.data, p.permlen, state)
end

function nextpermutation!(data::Vector, permlen::Int, idxvec::Vector{Int})
    perm = data[@view idxvec[1:permlen]]
    idxveclen = length(idxvec)
    
    permlen ≤ 0 && return (perm, [idxveclen + 1])
    
    if permlen < idxveclen
        j = permlen + 1
        while j ≤ idxveclen &&  idxvec[permlen] ≥ idxvec[j]
            j += 1
        end
    end
    if permlen < idxveclen && j ≤ idxveclen
        idxvec[permlen], idxvec[j] = idxvec[j], idxvec[permlen]; nothing
    else
        permlen < idxveclen && reverse!(idxvec, permlen+1)
        i = permlen - 1
        while i ≥ 1 && idxvec[i] ≥ idxvec[i+1]
            i -= 1
        end
        if i > 0
            j = idxveclen
            while j > i && idxvec[i] ≥ idxvec[j]
                j -= 1
            end
            idxvec[i], idxvec[j] = idxvec[j], idxvec[i]
            reverse!(idxvec, i+1)
        else
            idxvec[1] = idxveclen + 1
        end
        nothing
    end
    return perm, idxvec
end
