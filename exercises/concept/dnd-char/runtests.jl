using Test

include("dnd-character.jl")

@testset "Randomly generated ability is within range" begin
    for i in 1:1000
        @test 3 <= ability() <= 18
    end
end

@testset "Ability modifiers" begin
    @test modifier(3)::Int == -4
    @test modifier(4)::Int == -3
    @test modifier(5)::Int == -3
    @test modifier(6)::Int == -2
    @test modifier(7)::Int == -2
    @test modifier(8)::Int == -1
    @test modifier(9)::Int == -1
    @test modifier(10)::Int == 0
    @test modifier(11)::Int == 0
    @test modifier(12)::Int == 1
    @test modifier(13)::Int == 1
    @test modifier(14)::Int == 2
    @test modifier(15)::Int == 2
    @test modifier(16)::Int == 3
    @test modifier(17)::Int == 3
    @test modifier(18)::Int == 4
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
