function matrix(strmatrix)
    M = let mtrx = strmatrix
        mtrx = split(mtrx, "\n")
        mtrx = split.(mtrx, " ")
        mtrx = map(row-> parse.(Int, row), mtrx)
        reduce(hcat, mtrx)'
    end
    collect.((eachrow(M), eachcol(M)))
end
