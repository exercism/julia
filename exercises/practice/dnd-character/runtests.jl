using Test

include("dnd-character.jl")

function ischaracter(c)
    c.strength >= 3         && c.strength <= 18 &&
        c.dexterity >= 3    && c.dexterity <= 18 &&
        c.constitution >= 3 && c.constitution <= 18 &&
        c.intelligence >= 3 && c.intelligence <= 18 &&
        c.wisdom >= 3       && c.wisdom <= 18 &&
        c.charisma >= 3     && c.charisma <= 18 &&
        c.hitpoints == 10 + modifier(c.constitution)
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
    characters = DNDCharacter[]

    for i=1:10
        c = DNDCharacter()
        @testset "random character is valid and unique in history" begin
            @test ischaracter(c)
            @test !in(c, characters)
        end

        push!(characters, c)
    end
end
