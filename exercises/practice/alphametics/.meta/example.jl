include("permutations.jl")

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

An alphametic puzzle like "SEND + MORE == MONEY" can be represented as

1000S + 100E ... == 10000M + 1000 * O + 100N ...

We can simplify that to a set of coefficients for the left and right hand sides.

And a constraint on leading digits.

This function returns the letters of the puzzle in the order that they are used
in each of three vectors:

- coefficients for the left hand side
- coefficients for the right hand side
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
    return key, lhs, rhs, map(∈(leading_letters(puzzle)), key)
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
    is_valid(p, lhs, rhs, leads)

Return true iff `sum(p .* lhs) == sum(p .* rhs)` and no leading digit is 0.
"""
function is_valid(p, lhs, rhs, leads)
    # Using generators + zip leads to many fewer allocations than .*
    sum(p_i * lhs_i for (p_i, lhs_i) in zip(p, lhs)) ==
    sum(p_i * rhs_i for (p_i, rhs_i) in zip(p, rhs)) &&
    all(p[l_i] != 0 for (l_i, l) in enumerate(leads) if l)
end

"""
    solve(puzzle::String)

Return a Dict mapping each letter in the puzzle to an integer in 0:9.

Words cannot start with 0.
No two letters can share the same value.
"""
function solve(puzzle)
    (key, lhs, rhs, leads) = parse_puzzle(puzzle)
    for p in permutations(0:9, length(key))
        if is_valid(p, lhs, rhs, leads)
            return Dict(key .=> p)
        end
    end
    return nothing
end
