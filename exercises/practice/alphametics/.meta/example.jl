function solve(puzzle)
    terms = reverse.(split(replace(puzzle, r"[+=]"=> ""), "  "))
    leading = Set(last.(terms))
    addends, result = terms[1:end-1], last(terms)
    solution, maxdigits = Dict(), maximum(length, addends)
    
    function prunedfs(term=1, digit=1, colsum=0)
        if term ≤ length(addends) && digit ≤ length(addends[term])
            if haskey(solution, addends[term][digit])
                return prunedfs(term+1, digit, colsum + solution[addends[term][digit]])
            else
                for i in 0:9
                    iszero(i) && addends[term][digit] ∈ leading && continue
                    if i ∉ values(solution)
                        solution[addends[term][digit]] = i
                        check = prunedfs(term+1, digit, colsum + solution[addends[term][digit]])
                        isnothing(check) ? (delete!(solution, addends[term][digit]); nothing) : return check
                    end
                end
            end
        elseif term ≤ length(addends)
            return prunedfs(term+1, digit, colsum)
        else
            if digit < maxdigits
                if result[digit] ∈ leading && iszero(colsum%10)
                    nothing
                elseif haskey(solution, result[digit]) && solution[result[digit]] == colsum%10
                    return prunedfs(1, digit+1, colsum÷10)
                elseif !haskey(solution, result[digit]) && colsum%10 ∉ values(solution)
                    solution[result[digit]] = colsum%10
                    check = prunedfs(1, digit+1, colsum÷10)
                    isnothing(check) ? (delete!(solution, result[digit]); nothing) : return check
                end
            else
                check, added, total = [], [], digits(colsum)
                if length(total) == length(result[digit:end])
                    for (i, ch) in enumerate(result[digit:end])
                        !haskey(solution, ch) && total[i] ∈ values(solution) && break
                        ch ∈ leading && iszero(total[i]) && break
                        if !haskey(solution, ch) && total[i] ∉ values(solution)
                            solution[ch] = total[i]
                            push!(added, ch)
                        end
                        push!(check, solution[ch]) 
                    end
                check != total ? foreach(ch-> delete!(solution, ch), added) : return solution
                end
            end
        end                     
    end
    
    prunedfs()
end
