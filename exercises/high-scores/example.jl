function latest(scores::Array)
    return scores[length(scores)]
end

function personalBest(scores::Array)
    return sort(scores)[length(scores)]
end

function personalTopThree(scores::Array)
    if length(scores) <= 3
        return reverse(sort(scores))
    end
    return reverse(sort(scores)[length(scores) - 2:length(scores)])
end
