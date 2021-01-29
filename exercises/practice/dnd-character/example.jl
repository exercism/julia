function modifier(ability)
    return floor((ability - 10) / 2)
end

function ability()
    return rand(3:18)
end

mutable struct DNDCharacter
    strength::Int
    dexterity::Int
    constitution::Int
    intelligence::Int
    wisdom::Int
    charisma::Int
    hitpoints::Int
end

function DNDCharacter()
    strength = ability()
    dexterity = ability()
    constitution = ability()
    intelligence = ability()
    wisdom = ability()
    charisma = ability()
    hitpoints = 10 + modifier(constitution)

    return DNDCharacter(
        strength,
        dexterity,
        constitution,
        intelligence,
        wisdom,
        charisma,
        hitpoints,
    )
end
