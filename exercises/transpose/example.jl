function transpose_strings(input::AbstractArray)
    cols = length(input)
    cols == 0 && return []
    rows = maximum(map(x->length(x), input))
    result = fill("", rows)
    for i = 1:rows
        for j = 1:cols
            sym = ""
            if i <= length(input[j])
                delta = j-length(result[i])-1
                if delta > 0
                    sym = " " ^ delta
                end
                sym = sym * string(input[j][i])
            end
            result[i] = result[i] * sym
        end
    end
    result
end
