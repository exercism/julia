using Test

include("dnd-character.jl")

@testset "Randomly generated ability is within range" begin
    for i in 1:1000
        @test 3 <= ability() <= 18
    end
end

@testset "Ability modifiers are integers" begin
    @test typeof(modifier(7)) <: Integer
end

@testset "Ability modifiers" begin
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

@testset "Randomly generated character is valid" begin
    # Helper method to check if all abilities of a character are within the expected ranges.
    function ischaracter(c)
        3 <= c.strength     <= 18 &&
        3 <= c.dexterity    <= 18 &&
        3 <= c.constitution <= 18 &&
        3 <= c.intelligence <= 18 &&
        3 <= c.wisdom       <= 18 &&
        3 <= c.charisma     <= 18 &&
        c.hitpoints == 10 + modifier(c.constitution)
    end

    for i in 1:1000
        c = DNDCharacter()
        @test ischaracter(c)
    end
end
