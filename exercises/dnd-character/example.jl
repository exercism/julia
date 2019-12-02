function modifier(ability)
    return floor((ability - 10) / 2)
end

function ability()
    return rand(3:18)
end

mutable struct DndCharacter
    strength::Integer
    dexterity::Integer
    constitution::Integer
    intelligence::Integer
    wisdom::Integer
    charisma::Integer
    hitpoints::Integer

    function DndCharacter()
        strength = ability()
        dexterity = ability()
        constitution = ability()
        intelligence = ability()
        wisdom = ability()
        charisma = ability()
        hitpoints = 10 + modifier(constitution)

        return new(
            strength,
            dexterity,
            constitution,
            intelligence,
            wisdom,
            charisma,
            hitpoints,
        )
    end
end
