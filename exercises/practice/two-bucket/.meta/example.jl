function twobucket(bucket1, bucket2, goal, start)
    goal == (bucket1, bucket2)[start] && return (1, start, 0)
    goal == (bucket1, bucket2)[mod1(start+1,2)] && return (2, mod1(start+1,2), (bucket1, bucket2)[start])
    b1, b2 = isone(start) ? (bucket1, bucket2) : (bucket2, bucket1)
    n = findfirst(==(goal), b1 < b2 ? (b1:b1:lcm(b1,b2)) .% b2 : reverse((b2:b2:lcm(b1,b2)-1) .% b1))
    isnothing(n) && throw(DomainError(goal, "impossible"))
    empties = min(b1, b2)n ÷ max(b1, b2) - (goal < b1 < b2)
    goal < b1 ? (2n + 2empties, start, b2) : (2n + 2empties, 2, 0)
end
