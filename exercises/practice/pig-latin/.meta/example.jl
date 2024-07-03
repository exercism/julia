function translate(phrase)
    words = split(phrase, " ")
    fragments = map(translatefragment, words)

    join(fragments, " ")
end

vowelsound = r"^([aeiou]|xr|yt)"
consonantsound = r"^([^aeiou]+(?=y)|[^aeiou]?qu|[^aeiou]+)([a-z]+)"

function translatefragment(fragment)
    translated = fragment
    if !occursin(vowelsound, fragment)
        translated = replace(fragment, consonantsound => s"\g<2>\g<1>")
    end

    translated * "ay"
end
