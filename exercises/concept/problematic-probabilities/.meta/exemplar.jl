rationalize = .//
probabilities = ./

function checkmean(successes, trials)
    r, p = sum(rationalize(successes, trials)) // length(trials), sum(probabilities(successes, trials)) / length(trials)
    float(r) == p || r 
end

function checkprob(successes, trials)
    r, p = prod(rationalize(successes, trials)), prod(probabilities(successes, trials))
    float(r) == p || r
end
