function latest(scores::Array)
    return scores[length(scores)]
end

function personalbest(scores::Array)
    return sort(scores)[length(scores)]
end

function personaltopthree(scores::Array)
    if length(scores) <= 3
        return reverse(sort(scores))
    end
    return reverse(sort(scores)[length(scores)-2:length(scores)])
end
