function list(scores)
    return scores
end

function latest(scores)
    return scores[length(scores)]
end

function personalBest(scores)
    return sort(scores)[length(scores)]
end

function personalTopThree(scores)
    if length(scores) <= 3
        return reverse(sort(scores))
    end
    return reverse(sort(scores)[length(scores) - 2:length(scores)])
end
