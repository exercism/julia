getfactors(n, low, high) = [[i, n÷i] for i in low:isqrt(n) if iszero(n%i) && low ≤ n÷i ≤ high]

function nextpal(n, smallest)
    smallest && occursin(r"^9+$", "$n") && return n + 2
    !smallest && occursin(r"^10*1$", "$n") && return n - 2
    half = "$(parse(Int, "$n"[1:(ndigits(n)+1)÷2]) + (-1)^!smallest)"
    parse(Int, half * reverse(half)[1+isodd(ndigits(n)):end])
end

function nearestvalidpal(bound, smallest)
    half = "$bound"[1:(ndigits(bound)+1)÷2]
    pal = parse(Int, half * reverse(half)[1+isodd(ndigits(bound)):end])
    inrange = smallest ? bound ≤ pal : pal ≤ bound
    inrange ? pal : nextpal(pal, smallest)
end

function pal_n_facts(pal, low, high, smallest)
    ((smallest && pal > high^2) || (!smallest && pal < low^2)) && return nothing, []
    facts = getfactors(pal, low, high)
    isempty(facts) ? pal_n_facts(nextpal(pal, smallest), low, high, smallest) : (pal, facts)
end

function palindromeproducts(low, high, smallest)
    high < low && throw(ArgumentError("low is greater than high: $low > $high"))
    bound = smallest ? low^2 : high^2
    pal_n_facts(nearestvalidpal(bound, smallest), low, high, smallest)
end
