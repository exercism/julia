const score_table = (1 => 10, 5 => 5, 10 => 1)

"""
    score(x, y)

Return the score earned by a dart landing at coordinates (x, y).
"""
function score(x, y)
    z = hypot(x, y)
    for (radius, points) in score_table
        z <= radius && return points
    end
    return 0
end
