function translate(phrase)
    words = split(phrase, " ")
    fragments = map(translateFragment, words)

    join(fragments, " ")
end

vowelSound = r"^([aeiou]|xr|yt)"
consonantSound = r"^([^aeiou]+(?=y)|[^aeiou]?qu|[^aeiou]+)([a-z]+)"

function translateFragment(fragment)
    translated = fragment
    if !occursin(vowelSound, fragment)
        translated = replace(fragment, consonantSound => s"\g<2>\g<1>")
    end

    translated * "ay"
end
