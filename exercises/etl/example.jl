function transform(input::AbstractArray)
    output = []
    for i = input
        for j = map(lowercase, i[2])
            pair = (j, i[1])
            push!(output, pair)
        end
    end
    sort(output)
end

