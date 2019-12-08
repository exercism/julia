function myreverse(phrase::String)
    chars = Char[]
    for c in phrase
        push!(chars, c)
    end
    join(chars[end:-1:1])
end
