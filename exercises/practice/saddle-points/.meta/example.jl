function saddlepoints(M)
    isempty(M) && return Tuple{Int,Int}[]

    cols_min = minimum(M, dims=1)
    [Tuple(i) for i = CartesianIndices(M) if M[i] <= cols_min[i[2]] && M[i] >= maximum(view(M, i[1], :))]
end
