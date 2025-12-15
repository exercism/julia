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
end

Base.eltype(::Type{Permutations{T}}) where {T} = Vector{eltype(T)}

function Base.length(p::Permutations)
    length(p.data) < p.permlen && return 0
    return Int(prod(length(p.data) - p.permlen + 1:length(p.data)))
end

"""
    permutations(data)
Generate all permutations of an indexable object `data` in lexicographic order. Because the number of permutations
can be very large, this function returns an iterator object.
Use `collect(permutations(data))` to get an array of all permutations.
"""
permutations(data) = permutations(data, length(data))

"""
    permutations(data, permlen)
Generate all size `permlen` permutations of an indexable object `data`.
"""
function permutations(data, permlen::Integer)
    if permlen < 0
        permlen = length(data) + 1
    end
    Permutations(data, permlen)
end

function Base.iterate(p::Permutations, state = collect(eachindex(p.data)))
    (!isempty(state) && max(state[1], p.permlen) > length(p.data) || (isempty(state) && p.permlen > 0)) && return nothing
    nextpermutation!(p.data, p.permlen, state)
end

function nextpermutation!(data, permlen, state)
    perm = [data[state[i]] for i in 1:permlen]
    statelen = length(state)
    
    permlen ≤ 0 && return (perm, [statelen + 1])
    
    if permlen < statelen
        j = permlen + 1
        while j ≤ statelen &&  state[permlen] ≥ state[j]
            j += 1
        end
    end
    if permlen < statelen && j ≤ statelen
        state[permlen], state[j] = state[j], state[permlen]
    else
        permlen < statelen && reverse!(state, permlen+1)
        i = permlen - 1
        while i ≥ 1 && state[i] ≥ state[i+1]
            i -= 1
        end
        if i > 0
            j = statelen
            while j > i && state[i] ≥ state[j]
                j -= 1
            end
            state[i], state[j] = state[j], state[i]
            reverse!(state, i+1)
        else
            state[1] = statelen + 1
        end
    end
    return (perm, state)
end
