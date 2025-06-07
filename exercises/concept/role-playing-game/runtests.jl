using Test 

include("role-playing-game.jl")

@testset verbose = true "tests" begin
    @testset "1. Define type unions" begin
        @test StringOrMissing === Union{String, Missing}
        @test IntOrNothing === Union{Int, Nothing}
    end

    @testset "2. Implement the Player composite type" begin
        @testset "default Player" begin
            defaultplayer = Player()
            @test ismissing(defaultplayer.name)
            @test defaultplayer.level == 0
            @test defaultplayer.health == 100
            @test isnothing(defaultplayer.mana)
        end

        @testset "assigned Player" begin
            assignedplayer = Player(name="Joker", level=42, health=50, mana=200)
            @test assignedplayer.name == "Joker"
            @test assignedplayer.level == 42
            @test assignedplayer.health == 50
            @test assignedplayer.mana == 200
        end

        @testset "field annotation" begin
            @test_throws MethodError Player(name=24)
            @test_throws InexactError Player(level=4.2)
            @test_throws InexactError Player(health=4.2)
            @test_throws InexactError Player(mana=4.2)
        end
    end

    @testset "3. Introduce yourself" begin
        namedplayer = Player(name="Gandalf", level=1, health=42)
        @test introduce(namedplayer) == "Gandalf"

        unnamedplayer = Player(level=1, health=42)
        @test introduce(unnamedplayer) == "Mighty Magician"
    end

    @testset "4. Implement increment methods" begin
        @testset "increment name" begin
            @test increment("Merlin") == "Merlin the Great"
            @test increment(missing) == "The Great"
        end

        @testset "increment mana" begin
            @test increment(nothing) == 50
            @test increment(21) == 121
        end
    end

    @testset "5. Implement the title function" begin
        @testset "level < 42" begin
            defaultplayer = Player()
            name = title(defaultplayer)
            @test ismissing(name) && ismissing(defaultplayer.name)
            
            namedplayer = Player(name="Willard", level=21)
            name = title(Player(name="Willard", level=21))
            @test name == namedplayer.name == "Willard"
        end

        @testset "level = 42" begin
            namedplayer = Player(name="Genie", level=42, health=50)
            name = title(namedplayer)
            @test name == namedplayer.name == "Genie the Great"
            
            unnamedplayer = Player(level=42)
            name = title(unnamedplayer) 
            @test name == unnamedplayer.name == "The Great"
        end
    end

    @testset "6. Implement the revive function" begin
        @testset "dead player" begin
            player1 = Player(level=42, health=0)
            @test revive(player1) isa Player
            @test ismissing(player1.name)
            @test player1.level == 42
            @test player1.health == 100
            @test player1.mana == 50

            player2 = Player(level=17, health=0, mana=78)
            @test revive(player2) isa Player
            @test player2.level == 17
            @test player2.health == 100
            @test player2.mana == 178
        end

        @testset "alive player" begin
            player = Player(level=5, health=1)
            @test revive(player) isa Player
            @test player.health == 1
            @test isnothing(player.mana)
        end
    end
end
