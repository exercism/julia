function saddlepoints(matrix)
    isempty(matrix) && return Tuple{Int,Int}[]

    (cols_min,) = findmin(matrix, dims=1)
    (rows_max,) = findmax(matrix, dims=2)

    [Tuple(i) for i = CartesianIndices(matrix) if matrix[i] <= cols_min[i[2]] && matrix[i] >= rows_max[i[1]]]
end
