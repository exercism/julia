const score_table = (1 => 10, 5 => 5, 10 => 1)

function score(x::Real, y::Real)
    z = hypot(x, y)
    for (radius, points) in score_table
        z <= radius && return points
    end
    return 0
end
