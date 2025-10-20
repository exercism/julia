using Test

include("state-of-tic-tac-toe.jl")

@testset verbose = true "tests" begin

    @testset "Won games" begin
        @testset "Finished game where X won via left column victory" begin
            @test gamestate(["XOO", "X  ", "X  "]) == "win"
        end

        @testset "Finished game where X won via middle column victory" begin
            @test gamestate(["OXO", " X ", " X "]) == "win"
        end

        @testset "Finished game where X won via right column victory" begin
            @test gamestate(["OOX", "  X", "  X"]) == "win"
        end

        @testset "Finished game where O won via left column victory" begin
            @test gamestate(["OXX", "OX ", "O  "]) == "win"
        end

        @testset "Finished game where O won via middle column victory" begin
            @test gamestate(["XOX", " OX", " O "]) == "win"
        end

        @testset "Finished game where O won via right column victory" begin
            @test gamestate(["XXO", " XO", "  O"]) == "win"
        end

        @testset "Finished game where X won via top row victory" begin
            @test gamestate(["XXX", "XOO", "O  "]) == "win"
        end

        @testset "Finished game where X won via middle row victory" begin
            @test gamestate(["O O", "XXX", " O "]) == "win"
        end

        @testset "Finished game where X won via middle row victory" begin
            @test gamestate(["O  ", "XXX", " O "]) == "win"
        end

        @testset "Finished game where X won via bottom row victory" begin
            @test gamestate([" OO", "O X", "XXX"]) == "win"
        end

        @testset "Finished game where O won via top row victory" begin
            @test gamestate(["OOO", "XXO", "XX "]) == "win"
        end

        @testset "Finished game where O won via middle row victory" begin
            @test gamestate(["XX ", "OOO", "X  "]) == "win"
        end

        @testset "Finished game where O won via bottom row victory" begin
            @test gamestate(["XOX", " XX", "OOO"]) == "win"
        end

        @testset "Finished game where X won via falling diagonal victory" begin
            @test gamestate(["XOO", " X ", "  X"]) == "win"
        end

        @testset "Finished game where X won via rising diagonal victory" begin
            @test gamestate(["O X", "OX ", "X  "]) == "win"
        end

        @testset "Finished game where O won via falling diagonal victory" begin
            @test gamestate(["OXX", "OOX", "X O"]) == "win"
        end

        @testset "Finished game where O won via rising diagonal victory" begin
            @test gamestate(["  O", " OX", "OXX"]) == "win"
        end

        @testset "Finished game where X won via a row and a column victory" begin
            @test gamestate(["XXX", "XOO", "XOO"]) == "win"
        end

        @testset "Finished game where X won via two diagonal victories" begin
            @test gamestate(["XOX", "OXO", "XOX"]) == "win"
        end
    end


    @testset "Drawn games" begin
        @testset "Draw" begin
            @test gamestate(["XOX", "XXO", "OXO"]) == "draw"
        end

        @testset "Another draw" begin
            @test gamestate(["XXO", "OXX", "XOO"]) == "draw"
        end
    end


    @testset "Ongoing games" begin

        @testset "Ongoing game: one move in" begin
            @test gamestate(["   ", "X  ", "   "]) == "ongoing"
        end

        @testset "Ongoing game: two moves in" begin
            @test gamestate(["O  ", " X ", "   "]) == "ongoing"
        end

        @testset "Ongoing game: five moves in" begin
            @test gamestate(["X  ", " XO", "OX "]) == "ongoing"
        end
    end


    @testset "Invalid boards" begin

        @testset "Invalid board: X went twice" begin
            @test_throws ErrorException gamestate(["XX ", "   ", "   "])
        end

        @testset "Invalid board: O started" begin
            @test_throws ErrorException gamestate(["OOX", "   ", "   "])
        end

        @testset "Invalid board: X won and O kept playing" begin
            @test_throws ErrorException gamestate(["XXX", "OOO", "   "])
        end

        @testset "Invalid board: players kept playing after a win" begin
            @test_throws ErrorException gamestate(["XXX", "OOO", "XOX"])
        end
    end

end
