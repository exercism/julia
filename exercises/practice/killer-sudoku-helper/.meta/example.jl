# The following definitions of
#   - the Combinations struct,
#   - Base.length(c::Combinations),
#   - Base.eltype(::Type{Combinations}), and
#   - combinations(a, t::Integer)
# are taken from Combinatorics.jl, a combinatorics library for Julia.
#
# https://github.com/JuliaMath/Combinatorics.jl/blob/v1.0.2/src/combinations.jl
# https://github.com/JuliaMath/Combinatorics.jl/blob/v1.0.2/LICENSE.md
#
# It is published under the following license:
#     Copyright (c) 2013-2015: Alessandro Andrioni, Jiahao Chen and other contributors.
#     Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#     The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

struct Combinations
    n::Int
    t::Int
end

function Base.iterate(c::Combinations, s = [min(c.t - 1, i) for i in 1:c.t])
    if c.t == 0 # special case to generate 1 result for t==0
        isempty(s) && return (s, [1])
        return
    end
    for i in c.t:-1:1
        s[i] += 1
        if s[i] > (c.n - (c.t - i))
            continue
        end
        for j in i+1:c.t
            s[j] = s[j-1] + 1
        end
        break
    end
    s[1] > c.n - c.t + 1 && return
    (s, s)
end

Base.length(c::Combinations) = binomial(c.n, c.t)

Base.eltype(::Type{Combinations}) = Vector{Int}

"""
    combinations(a, n)

Generate all combinations of `n` elements from an indexable object `a`. Because the number
of combinations can be very large, this function returns an iterator object.
Use `collect(combinations(a, n))` to get an array of all combinations.
"""
function combinations(a, t::Integer)
    if t < 0
        # generate 0 combinations for negative argument
        t = length(a) + 1
    end
    reorder(c) = [a[ci] for ci in c]
    (reorder(c) for c in Combinations(length(a), t))
end

"""
    combinations_in_cage(cagesum, cagesize, exclude=[])

Return all valid combinations of digits in a Killer Sudoku cage with the given sum and size, restricted by the excluded numbers.
"""
function combinations_in_cage(cagesum, cagesize, exclude=[])
    all_numbers = collect(1:9)
    res = Vector{Int}[]
    for c in combinations(all_numbers, cagesize)
        isempty(intersect(c, exclude)) || continue
        sum(c) == cagesum && push!(res, c)
    end
    res
end
