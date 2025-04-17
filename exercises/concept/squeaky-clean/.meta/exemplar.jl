function transform(ch)
    if ch == '-'
        "_"
    elseif 'α' ≤ ch ≤ 'ω' 
        "?"
    elseif isspace(ch) || isdigit(ch)
        ""
    elseif isuppercase(ch)
        "-$(lowercase(ch))"
    else
        string(ch)
    end
end

# The default delimiter is "", so it is only included below for documentation
clean(str) = join([transform(ch) for ch in str], "")
