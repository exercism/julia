function bob(stimulus::AbstractString)
    stimulus = strip(stimulus)

    if issilence(stimulus)
        return "Fine. Be that way!"
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
    all(isupper, stimulus) && return true
    !any(isalpha, stimulus) && return false

    for c in stimulus
        # ignore all non-letter chars
        if isalpha(c) && !isupper(c)
            return false
        end
    end

    return true
end
