using Test 

include("role-playing-game.jl")

@testset verbose = true "tests" begin
    @testset "1. Define type unions" begin
        @test IntOrNothing === Union{Int, Nothing}
        @test StringOrMissing === Union{String, Missing}
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
        @testset "with their own name" begin
            namedplayer = Player(name="Gandalf", level=1, health=42)
            @test introduce(namedplayer) == "Gandalf"

            unnamedplayer = Player(level=1, health=42)
            @test introduce(unnamedplayer) == "Mighty Magician"
        end
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
        @testset "lower level" begin
            defaultplayer = Player()
            title(defaultplayer)
            @test ismissing(defaultplayer.name)
            
            namedplayer = Player(name="Willard", level=21)
            title(Player(name="Willard", level=21))
            @test namedplayer.name == "Willard"
        end

        @testset "top level" begin
            namedplayer1 = Player(name="Genie", level=42, health=50)
            title(namedplayer1)
            @test namedplayer1.name == "Genie the Great"
            
            unnamedplayer = Player(level=42)
            title(unnamedplayer) 
            @test unnamedplayer.name == "The Great"
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

    @testset "Implement the spell casting function" begin
        @testset "no mana" begin
            player1 = Player()
            damage = castspell(player1, 40)
            @test damage == 0
            @test player1.health == 60
        end

        @testset "insufficient mana" begin
            player2 = Player(name="Baboo", level=2, mana=25)
            damage = castspell(player2, 35)
            @test damage == 0
            @test isnothing(player2.mana)
        end

        @testset "sufficient mana" begin
            player3 = Player(name="player", level=42, mana=57)
            damage = castspell(player3, 15)
            @test damage == 30
            @test player3.mana == 42
        end
    end
end
