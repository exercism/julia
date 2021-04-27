# Design

## Considered but dropped

Implement a `high_score` function that returns the leader, e.g.

```julia
function high_score(scores)
    best = findmax(scores)
    best[2] => best[1]
end
```

This function would add too much complexity, as it would require handling empty collections, situations where players have the same score etc.
