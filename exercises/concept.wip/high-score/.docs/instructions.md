# Instructions

In this exercise, you're implementing a way to keep track of the high scores for the most popular game in your local arcade hall.

## 1. Add players to the high score board

To add a player to the high score board, define two `add_player!` methods that take the following arguments:

- The first argument is the dictionary of scores.
- The second argument is the name of a player as a string.
- The third argument is the score as an integer.
  This argument is optional, when no value is given, the score should be set to 0.

```julia
julia> scores = Dict{String, Int}()
Dict{String, Int64}()

julia> add_player!(scores, "Liselot", 486373)
Dict{String, Int64} with 1 entry:
  "Liselot" => 486373

julia> add_player!(scores, "Éimhín")
Dict{String, Int64} with 2 entries:
  "Liselot" => 486373
  "Éimhín"  => 0
```

## 2. Remove players from the score board

To remove a player from the high score board, define `remove_player!`, which takes 2 arguments:

- The first argument is the dictionary of scores.
- The second argument is the name of the player as a string.

```julia
julia> scores = Dict(
           "Liselot" => 486373,
           "Éimhín"  => 0,
       )
Dict{String, Int64} with 2 entries:
  "Liselot" => 486373
  "Éimhín"  => 0

julia> remove_player!(scores, "Liselot")
Dict{String, Int64} with 1 entry:
  "Éimhín" => 0
```

## 3. Update a player's score

To update a players score by replacing the previous score, define `update_score!`, which takes 3 arguments:

- The first argument is the dictionary of scores.
- The second argument is the name of the player as a string, whose score you wish to update.
- The third argument is the score that you wish to set stored high score to.

```julia
julia> scores = Dict(
           "Liselot" => 486373,
           "Éimhín"  => 0,
       )
Dict{String, Int64} with 2 entries:
  "Liselot" => 486373
  "Éimhín"  => 0

julia> update_score!(scores, "Éimhín", 89479) # TODO: Should this return the dict?
89479

julia> scores
Dict{String, Int64} with 2 entries:
  "Liselot" => 486373
  "Éimhín"  => 89479
```

## 4. Reset a player's score

To reset a player's score, define `reset_score!`, which takes 2 arguments:

- The first argument is the dictionary of scores.
- The second argument is the name of the player as a string, whose score you wish to reset.

```julia
julia> scores = Dict(
           "Liselot" => 486373,
           "Éimhín"  => 0,
       )
Dict{String, Int64} with 2 entries:
  "Liselot" => 486373
  "Éimhín"  => 0

julia> reset_score!(scores, "Liselot") # TODO: Should this return the dict?
0

julia> scores
Dict{String, Int64} with 2 entries:
  "Liselot" => 0
  "Éimhín"  => 0
```

## 5. Get a list of players

To get a list of players, define `players`, which takes 1 argument:

- The first argument is the dictionary of scores.

```julia
julia> scores = Dict(
           "Liselot" => 486373,
           "Éimhín"  => 0,
       )
Dict{String, Int64} with 2 entries:
  "Liselot" => 486373
  "Éimhín"  => 0

julia> players(scores)
2-element Vector{String}:
 "Liselot"
 "Éimhín"
```
