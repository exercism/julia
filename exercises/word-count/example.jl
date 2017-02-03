function wordcount(sentence::AbstractString)
    sentence = lowercase(sentence)
    words = Dict()
    for rx = eachmatch(r"[a-z]+'[a-z]+|[0-9a-z]+", sentence)
        word = rx.match
        words[word] = get(words, word, 0) + 1
    end
    words
end
