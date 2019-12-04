function reversestring(phrase::String)
    chars = []
    for i in phrase
        push!(chars, i)
    end
    newchars=chars[end:-1:1]
    newphrase= ""
    for j in newchars
        newphrase = "$newphrase$j"
    end
    newphrase
end
