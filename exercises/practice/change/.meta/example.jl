function change(coins, target)
    memo = Dict(0 => (0, 0))
    for n in 1:target
        mincoins, previousn = minimum([(first(get(memo, prevn, (Inf, 0))), prevn) for prevn in n .- coins])
        mincoins < Inf && (memo[n] = (mincoins+1, previousn))
    end
    
    !haskey(memo, target) && throw(DomainError(target, "Not Possible"))
    
    changeback, previoustarget = [], Inf
    while 0 < target
        previoustarget = last(memo[target])
        push!(changeback, target - previoustarget)
        target = previoustarget
    end
    
    reverse!(changeback)
end
