function rows(letter)
    letter == "A" && return ["A"]

    letters = 'A':'Z' |> collect
    letter_index = findfirst(x -> x == only(letter), letters)
    rowslist = []

    # loop to the middle of the diamond
    for i in 1:letter_index
        row = [' ' for _ in 1:(2 * letter_index - 1)]
        row[letter_index - i + 1] = row[letter_index + i - 1] = letters[i]
        push!(rowslist, join(row))
    end

    # reflect most of the top half and concatenate
    vcat(rowslist, rowslist[(end - 1):-1:1])
end
