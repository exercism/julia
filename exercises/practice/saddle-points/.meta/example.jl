function saddlepoints(M)
    isempty(M) && return Tuple{Int,Int}[]

    cols_min = minimum(M, dims=1)
    rows_max = maximum(M, dims=2)

    [Tuple(i) for i = CartesianIndices(M) if rows_max[i[1]] <= M[i] <= cols_min[i[2]]]
end
