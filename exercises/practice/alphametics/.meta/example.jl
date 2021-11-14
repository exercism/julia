### Inline permutations.jl for CI and testing purposes
# Extract of Combinatorics.jl
#
# You may (or may not!) want to call the function `permutations(a, t)` in your
# solution. If you would like to use it, include this file with
# `include("permutations.jl")`.
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

struct Permutations{T}
    a::T
    t::Int
end

Base.eltype(::Type{Permutations{T}}) where {T} = Vector{eltype(T)}

Base.length(p::Permutations) = (0 <= p.t <= length(p.a)) ? factorial(length(p.a), length(p.a)-p.t) : 0

"""
    permutations(a)

Generate all permutations of an indexable object `a` in lexicographic order. Because the number of permutations
can be very large, this function returns an iterator object.
Use `collect(permutations(a))` to get an array of all permutations.
"""
permutations(a) = Permutations(a, length(a))

"""
    permutations(a, t)

Generate all size `t` permutations of an indexable object `a`.
"""
function permutations(a, t::Integer)
    if t < 0
        t = length(a) + 1
    end
    Permutations(a, t)
end

function Base.iterate(p::Permutations, s = collect(1:length(p.a)))
    (!isempty(s) && max(s[1], p.t) > length(p.a) || (isempty(s) && p.t > 0)) && return
    nextpermutation(p.a, p.t ,s)
end

function nextpermutation(m, t, state)
    perm = [m[state[i]] for i in 1:t]
    n = length(state)
    if t <= 0
        return(perm, [n+1])
    end
    s = copy(state)
    if t < n
        j = t + 1
        while j <= n &&  s[t] >= s[j]; j+=1; end
    end
    if t < n && j <= n
        s[t], s[j] = s[j], s[t]
    else
        if t < n
            reverse!(s, t+1)
        end
        i = t - 1
        while i>=1 && s[i] >= s[i+1]; i -= 1; end
        if i > 0
            j = n
            while j>i && s[i] >= s[j]; j -= 1; end
            s[i], s[j] = s[j], s[i]
            reverse!(s, i+1)
        else
            s[1] = n+1
        end
    end
    return (perm, s)
end

### End of permutations.jl

### Simple helper functions

"""
    leading_letters(puzzle)

Return each unique character that leads a word in the puzzle.
"""
function leading_letters(puzzle)
    unique(first.(split(puzzle, r"[^A-Z]+")))
end

"""
    letters(puzzle)

Return the unique letters in the puzzle in a deterministic order.
"""
letters(puzzle) = unique(c for c in puzzle if c in 'A':'Z')


### British Informatics Olympiad inspired brute-force solution

"""
    parse_puzzle(puzzle)

An alphametic puzzle like "A + A + B == AA" can be represented as an equation
and a list of letters used as leading digits. The equation looks like this:

    A + A + B == 10A + A

We can rearrange and simplify that to a set of coefficients:

    2A + B == 11A
    -9A + B == 0

This function returns three vectors:

- the unique letters of the puzzle in the order that they are used in the next
  two vectors
- coefficients for each letter
- a boolean vector indicating if the letter is ever used as a leading digit

"""
function parse_puzzle(puzzle::String)
    key = letters(puzzle)
    lhs = zeros(Int, length(key))
    rhs = zeros(Int, length(key))
    acc = lhs
    for token in split(puzzle)
        if token == "=="
            acc = rhs
        elseif token != "+"
            parse_word!(acc, key, token)
        end
    end
    coeffs = lhs .- rhs
    return key, coeffs, map(∈(leading_letters(puzzle)), key)
end

"""
    parse_word!(acc, key, word)

`acc` is a vector of coefficients to apply to the variables in `key`.
`word` is a string representing more coefficients for those variables.

Update `acc` by adding these coefficients together.

"""
function parse_word!(acc, key, word)
    multiplier = 10 ^ (length(word) - 1)
    for l in word
        acc[findfirst(==(l), key)] += multiplier
        multiplier ÷= 10
    end
    acc
end

"""
    is_valid(p, coeffs, leads)

Return true iff `sum(p .* coeffs) == 0` and no leading digit is 0.
"""
function is_valid(p, coeffs, leads)
    # Using generators + zip leads to many fewer allocations than .*
    sum(p_i * coeffs_i for (p_i, coeffs_i) in zip(p, coeffs)) == 0 &&
    all(p[l_i] != 0 for (l_i, l) in enumerate(leads) if l)
end

"""
    solve(puzzle::String)

Return a Dict mapping each letter in the puzzle to an integer in 0:9.

Words cannot start with 0.
No two letters can share the same value.
"""
function solve(puzzle)
    (key, coeffs, leads) = parse_puzzle(puzzle)
    for p in permutations(0:9, length(key))
        if is_valid(p, coeffs, leads)
            return Dict(key .=> p)
        end
    end
    return nothing
end
