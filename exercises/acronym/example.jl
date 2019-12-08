#example.jl
function acronym(phrase)
    regex = "[A-Z]+['a-z]*|['a-z]+"
    return join([uppercase(word.match[1]) for word in eachmatch(Regex(regex), phrase)], "")
end
