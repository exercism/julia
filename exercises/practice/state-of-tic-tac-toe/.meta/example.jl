
function gamestate(board)
    M = reshape([col == ' ' ? 0 : (-1)^(col == 'O') for row in board for col in row], (3,3))
    mini, maxi = extrema([sum(M, dims=1)..., sum(M, dims=2)..., M[1,1]+M[2,2]+M[3,3], M[1,3]+M[2,2]+M[3,1]])
    (sum(M) ∉ (0, 1) || maxi == 3 && mini == -3) && error("Invalid board")
    (maxi == 3 || mini == -3) ? "win" : 0 ∈ M ? "ongoing" : "draw"
end



# Both solutions below are adapted from 2020 versions by Sascha Mann and Jeremy Walker
# Significant changes were needed to pass the current tests

# Version 1  (kind of elegant, for people who like linear algebra)
# https://github.com/exercism/research_experiment_1/blob/julia-dev/exercises/julia-1-a/.meta/example2.jl

# using LinearAlgebra

# const x = 1
# const o = -1

# function wins(b_int, player)
#     # It's a win if any of the rows, columns, or diagonals add up to ±3
#     row_wins = count(sum(row) == 3 * player for row in eachrow(b_int))
#     col_wins = count(sum(col) == 3 * player for col in eachcol(b_int))
#     diag_wins = (sum(diag(b_int)) == 3 * player ? 1 : 0) + 
#                 (sum(diag(rotr90(b_int))) == 3 * player ? 1 : 0)
#     (row_wins, col_wins, diag_wins)
# end

# function valid_double_win(wins)
#     rows, cols, diags = wins
#     sum(wins) == 2 && rows < 2 && cols < 2
# end

# function gamestate(board)
#     # Parse to Int Matrix
#     b_str = hcat(split.(board, "")...)
#     replace!(b_str, "X" => "1")
#     replace!(b_str, " " => "0")
#     replace!(b_str, "O" => "-1")
#     b_int = parse.(Int, b_str)

#     sum(b_int) ∉ (0, 1) && error("Must take turns in order!")

#     x_wins = wins(b_int, x)
#     o_wins = wins(b_int, o)
#     (sum(x_wins) > 0 && sum(o_wins) > 0) && error("Too many wins!")

#     total_wins = sum(x_wins) + sum(o_wins)
#     if total_wins == 1 || valid_double_win(x_wins) || valid_double_win(o_wins)
#         "win"
#     elseif total_wins > 1
#         error("Too many wins!")
#     elseif sum(b_int) == 1 && !any(x == 0 for x in b_int)
#         "draw"
#     else
#         "ongoing"
#     end
# end

# ========================================================================


# Version 2  (about 3x faster than version 1)
# https://github.com/exercism/research_experiment_1/blob/julia-dev/exercises/julia-1-a/.meta/example.jl

# function wins(b, player)
#     row_wins = col_wins = diag_wins = 0

#     for i in 1:3
#         row_wins += b[i, 1] == player && (b[i, 1] == b[i, 2] == b[i, 3]) ? 1 : 0
#         col_wins += b[1, i] == player && (b[1, i] == b[2, i] == b[3, i]) ? 1 : 0
#     end

#     diag_wins += b[1, 1] == player && (b[1, 1] == b[2, 2] == b[3, 3]) ? 1 : 0
#     diag_wins += b[1, 3] == player && (b[1, 3] == b[2, 2] == b[3, 1]) ? 1 : 0

#     (row_wins, col_wins, diag_wins)
# end

# function valid_double_win(wins)
#     rows, cols, diags = wins
#     sum(wins) == 2 && rows < 2 && cols < 2
# end

# function gamestate(board)
#     # Parse to Matrix
#     b = hcat(split.(board, "")...)

#     # Invalid boards
#     nₒ = count(x -> x == "O", b)
#     nₓ = count(x -> x == "X", b)
#     # Not taking turns in order 
#     if nₒ > nₓ || abs(nₒ - nₓ) > 1
#         error("Invalid board: did not take turns in order")
#     end

#     x_wins = wins(b, "X")
#     o_wins = wins(b, "O")
#     (sum(x_wins) > 0 && sum(o_wins) > 0) && error("Too many wins!")

#     total_wins = sum(x_wins) + sum(o_wins)
#     if total_wins == 1 || valid_double_win(x_wins) || valid_double_win(o_wins)
#         "win"
#     elseif total_wins > 1
#         error("Too many wins!")
#     elseif " " ∉ b
#         "draw"
#     else
#         "ongoing"
#     end
# end
