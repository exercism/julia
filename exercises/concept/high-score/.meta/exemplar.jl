"""
    add_player!(scores, name, score=0)

Add a player to the score board.
"""
add_player!(scores, name, score=0) = push!(scores, name => score)

"""
    remove_player!(scores, name)

Remove a player from the score board.
"""
remove_player!(scores, name) = delete!(scores, name)

"""
    update_score!(scores, name, score)

Update the score of a player on the score board.
"""
update_score!(scores, name, score) = scores[name] = score

"""
    reset_score!(scores, name)

Reset the score of a player on the score board.
"""
reset_score!(scores, name) = update_score!(scores, name, 0)

"""
    players(scores)

Return a list of all players on the score board.
"""
players(scores) = collect(keys(scores))
