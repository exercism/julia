# Extract of Combinatorics.jl
#
# You may (or may not!) want to call the function `permutations(a, t)` in your
# solution.
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
    length::Int
end

Base.eltype(::Type{Permutations{T}}) where {T} = Vector{eltype(T)}

function Base.length(p::Permutations)
    length(p.data) < p.length && return 0
    return Int(prod(length(p.data) - p.length + 1:length(p.data)))
end

"""
    permutations(data)
Generate all permutations of an indexable object `data` in lexicographic order. Because the number of permutations
can be very large, this function returns an iterator object.
Use `collect(permutations(data))` to get an array of all permutations.
"""
permutations(data) = Permutations(data, length(data))

"""
    permutations(data, len)
Generate all size `len` permutations of an indexable object `data`.
"""
function permutations(data, len::Integer)
    if len < 0
        len = length(data) + 1
    end
    Permutations(data, len)
end

function Base.iterate(p::Permutations, state = collect(1:length(p.data)))
    (!isempty(state) && max(state[1], p.length) > length(p.data) || (isempty(state) && p.length > 0)) && return nothing
    nextpermutation(p.data, p.length , state)
end

function nextpermutation(data, len, state)
    perm = [data[state[i]] for i in 1:len]
    statelen = length(state)
    
    len ≤ 0 && return (perm, [statelen+1])
    
    statecopy = copy(state)
    if len < statelen
        j = len + 1
        while j ≤ statelen &&  statecopy[len] ≥ statecopy[j]
            j += 1
        end
    end
    if len < statelen && j ≤ statelen
        statecopy[len], statecopy[j] = statecopy[j], statecopy[len]
    else
        len < statelen && reverse!(statecopy, len+1)
        i = len - 1
        while i ≥ 1 && statecopy[i] ≥ statecopy[i+1]
            i -= 1
        end
        if i > 0
            j = statelen
            while j > i && statecopy[i] >= statecopy[j]
                j -= 1
            end
            statecopy[i], statecopy[j] = statecopy[j], statecopy[i]
            reverse!(statecopy, i+1)
        else
            statecopy[1] = statelen + 1
        end
    end
    return (perm, statecopy)
end
