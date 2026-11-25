function calculate_frequencies(texts::Vector{String})
    tasks = [Threads.@spawn calculate_frequencies(text) for text in texts]
    reduce(mergewith(+), fetch.(tasks); init=Dict{Char,Int}())
end

function calculate_frequencies(text::String)
    freqs = Dict{Char,Int}()
    for c in lowercase.(filter(isletter, text))
        freqs[c] = get(freqs, c, 0) + 1
    end
    freqs
end
