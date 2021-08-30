"""
    pythagorean_triplets(n)

Find all positive integer triplets `(a, b, c)` s.t. `a + b + c = n` and `a < b < c` and `a^2 + b^2 == c^2`.
"""
# cmcaine's answer, with thanks to akshu3398.
function pythagorean_triplets(n)
    triplets = NTuple{3, Int}[]
    # Lower bound because the smallest triple is 3, 4, 5.
    # Upper bound implied by a < b < c && a + b + c == n.
    for a in 3:cld(n, 3) - 1
        # Derived by eliminating c from these simultaneous
        # equations and solving for b:
        #     a^2 + b^2 = c^2
        #     a + b + c = n
        b = (n^2 - 2n * a) / (2 * (n - a))
        if a < b && isinteger(b)
            c = n - a - b
            # Proof that b < c:
            # Let b = c. Then a^2 + b^2 = c^2 ≡ a^2 = 0 but we know that a ≠ 0.
            # Let b > c. a^2 + b^2 = c^2 ≡ a^2 = c^2 - b^2.
            #    If b > c, a^2 < 0, but that is impossible for real numbers.
            push!(triplets, (a, b, c))
        end
    end
    return sort!(triplets)
end
