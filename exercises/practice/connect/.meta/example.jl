#=
The approach below is essentially an implementation of bfs/floodfill.
 - connector does the bfs, using the six possible steps and tracking which have been seen, returns true/false
   depending on if there is a path is found connecting two edges of the board.
 - wins finds starting points for connector, and returns true if the provided points results in a win.
 - connect processes the board to separate points into coordinates for wins to filter through and then returns the winner,
   if there is one. The coordinates have been transposed for O, so that wins and connector can work with X or O equally.
=#
function connector(unseen, points, dim, nextpoints=Set())
    for point in points, step in ((1,0),(-1,0),(0,1),(0,-1),(1,-1),(-1,1))
        nextpoint = point .+ step
        if nextpoint ∈ unseen
            first(nextpoint) == dim && return true
            push!(nextpoints, nextpoint)
            delete!(unseen, nextpoint)
        end
    end
    !isempty(nextpoints) && connector(unseen, nextpoints, dim)
end

function wins(points, dim)
    for point in filter(isone ∘ first, points)
        (isone(dim) || connector(setdiff(points, Set([point])), Set([point]), dim)) && return true
    end
    false
end

function connect(board)
    newboard, Xs, Os = hcat(split.(strip.(board), " ")...), Set(), Set()
    for i in axes(newboard,1), j in axes(newboard,2)
        newboard[i,j] == "X" && push!(Xs, (i,j))
        newboard[i,j] == "O" && push!(Os, (j,i))
    end
    wins(Xs, first(size(newboard))) ? "X" : wins(Os, last(size(newboard))) ? "O" : ""
end
