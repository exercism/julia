function transform(input::Dict)
    output = []
    for i = input
        for j = map(lowercase, i[2])
            pair = (j, i[1])
            push!(output, pair)
        end
    end
    Dict(output)
end

