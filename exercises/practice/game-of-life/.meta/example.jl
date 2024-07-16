function gameoflife(matrix)
    neighbors(x,y) = ((x+1,y),(x+1,y+1),(x,y+1),(x-1,y),(x-1,y-1),(x,y-1),(x-1,y+1),(x+1,y-1))
    rows, cols = size(matrix)
    padded = hcat(zeros(Int, rows+2), vcat(zeros(Int, cols)', matrix, zeros(Int, cols)'), zeros(Int, rows+2))
    for i in 2:rows+1, j in 2:cols+1
        alive = sum(padded[x, y] for (x, y) in neighbors(i, j))
        alive == 3 && (matrix[i-1, j-1] = 1)
        (alive < 2 || 3 < alive) && (matrix[i-1, j-1] = 0)
    end
    matrix
end
