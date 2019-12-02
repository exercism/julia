# canonical data version: 1.1.0
using Test

include("dnd-character.jl")

function ischaracter(dnd)
    dnd.strength >= 3         && dnd.strength <= 18 &&
        dnd.dexterity >= 3    && dnd.dexterity <= 18 &&
        dnd.constitution >= 3 && dnd.constitution <= 18 &&
        dnd.intelligence >= 3 && dnd.intelligence <= 18 &&
        dnd.wisdom >= 3       && dnd.wisdom <= 18 &&
        dnd.charisma >= 3     && dnd.charisma <= 18 &&
        dnd.hitpoints == 10 + modifier(dnd.constitution)
end

@testset "ability modifier" begin
    @test modifier(3) == -4
    @test modifier(4) == -3
    @test modifier(5) == -3
    @test modifier(6) == -2
    @test modifier(7) == -2
    @test modifier(8) == -1
    @test modifier(9) == -1
    @test modifier(10) == 0
    @test modifier(11) == 0
    @test modifier(12) == 1
    @test modifier(13) == 1
    @test modifier(14) == 2
    @test modifier(15) == 2
    @test modifier(16) == 3
    @test modifier(17) == 3
    @test modifier(18) == 4
end

@testset "random ability is within range" begin
    abil = ability()
    @test abil >= 3 && abil <= 18
end

@testset "random character is valid" begin
    global characters = DndCharacter[]
    global history = DndCharacter[]

    for i=1:10
        push!(characters, DndCharacter())

        @testset "random character is valid and unique in history" begin
            @test ischaracter(characters[i])
            @test !in(characters[i], history)
        end

        push!(history, characters[i])
    end
end
