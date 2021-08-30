using LinearAlgebra
#Credit to u/SingularInfinity on Reddit: https://www.reddit.com/r/dailyprogrammer/comments/6i60lr/20170619_challenge_320_easy_spiral_ascension/djb8po0

function spiral_matrix(n::Int)
    n < 0 && throw(DomainError(n, "n should be positive"))
    n == 0 && return Matrix{Int}(undef,0,0)
    n == 1 && return reshape(Int[1], 1, 1)
    m = (2n - 1) .+ spiral_matrix(n-1)
    return [ Transpose(1:n); rot180(m) n+1:2n-1 ]
end
