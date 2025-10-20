StringOrMissing = Union{String, Missing}
IntOrNothing = Union{Int, Nothing}

@kwdef mutable struct Player
    name::StringOrMissing = missing
    level::Int = 0
    health::Int = 100
    mana::IntOrNothing = nothing
end

introduce(player::Player) = ismissing(player.name) ? "Mighty Magician" : player.name

increment(name::StringOrMissing) = ismissing(name) ? "The Great" : name * " the Great"
increment(mana::IntOrNothing) = isnothing(mana) ? 50 : 100 + mana

title!(player::Player) = player.name = player.level == 42 ? increment(player.name) : player.name

function revive!(player::Player)
    player.health > 0 && return player
    player.health, player.mana = 100, increment(player.mana)
    player
end
