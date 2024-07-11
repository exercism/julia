function dominoes(stones)
    function dfs(stones, chain, indices)
        length(indices) == length(stones) && first(first(chain)) == last(last(chain)) && return true
        for (i, stone) in enumerate(stones)
            if i ∉ indices && last(last(chain)) ∈ stone
                check = dfs(stones, push!(chain, last(last(chain)) == first(stone) ? stone : reverse(stone)), push!(indices, i))
                check && return true
                delete!(indices, i)
                pop!(chain)
            end
        end
        false
    end
    isempty(stones) || dfs(stones, [first(stones)], Set(1))
end
