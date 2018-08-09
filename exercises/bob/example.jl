function bob(stimulus::AbstractString)
    stimulus = strip(stimulus)

    if issilence(stimulus)
        return "Fine. Be that way!"
    elseif isquestion(stimulus) && isshouting(stimulus)
        return "Calm down, I know what I'm doing!"
    elseif isshouting(stimulus)
        return "Whoa, chill out!"
    elseif isquestion(stimulus)
        return "Sure."
    else
        return "Whatever."
    end
end

issilence(stimulus::AbstractString) = isempty(stimulus)
isquestion(stimulus::AbstractString) = endswith(stimulus, '?')

function isshouting(stimulus::AbstractString)
    all(isuppercase, stimulus) && return true
    !any(isletter, stimulus) && return false

    for c in stimulus
        # ignore all non-letter chars
        if isletter(c) && !isuppercase(c)
            return false
        end
    end

    return true
end
