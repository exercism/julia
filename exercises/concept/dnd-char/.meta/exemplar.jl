"""
    ability()

Return a valid ability value.
"""
function ability()
    # While the exercise doesn't explicitely require it, we simulate 4 dice rolls and discard the smallest roll.
    # A minimal solution would be ability() = rand(3:18)

    # Throw 4 dice
    dice = [rand(1:6) for i in 1:4]

    # Sort the dice so that [2:end] excludes the lowest roll
    sort!(dice)
    sum(dice[2:end])
end

"""
    modifier(ability)

Return the modifier based on an ability value.
"""
modifier(ability) = fld(ability - 10, 2)

Base.@kwdef struct DNDCharacter
    strength::Int = ability()
    dexterity::Int = ability()
    constitution::Int = ability()
    intelligence::Int = ability()
    wisdom::Int = ability()
    charisma::Int = ability()
    hitpoints::Int = 10 + modifier(constitution)
end
