@enum State ONGOING WIN LOSE

mutable struct Game
    word::String
    masked::String
    remaining::Int
    state::State
    guesses::Set{Char}
end

new_game(word) = Game(word, "_"^length(word), 9, ONGOING, Set{Char}())
state(game) = game.state
masked_word(game) = game.masked
remaining_failures(game) = game.remaining

function guess!(game, letter)
    game.state ∈ (WIN, LOSE) && error("Game is already over")

    if letter ∉ game.word || letter in game.guesses
        if game.remaining == 0
            game.state = LOSE
        else
            game.remaining -= 1
        end
    else
        push!(game.guesses, letter)
        if game.word ⊆ game.guesses
            game.state = WIN
        end
    end

    game.masked = join(c in game.guesses ? c : '_' for c in game.word)
end
