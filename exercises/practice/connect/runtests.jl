using Test

include("connect.jl")

@testset verbose = true "tests" begin
    @testset "an empty board has no winner" begin
        board = [
            ". . . . .",
            " . . . . .",
            "  . . . . .",
            "   . . . . .",
            "    . . . . ."
        ]
        @test connect(board) == ""
    end

    @testset "an empty 1x1 board has no winner" begin
        board = [
            "."
        ]
        @test connect(board) == ""
    end

    @testset "X can win on a 1x1 board" begin
        board = [
            "X"
        ]
        @test connect(board) == "X"
    end

    @testset "O can win on a 1x1 board" begin
        board = [
            "O"
        ]
        @test connect(board) == "O"
    end

    @testset "only edges does not make a winner" begin
        board = [
            "O O O X",
            " X . . X",
            "  X . . X",
            "   X O O O"
        ]
        @test connect(board) == ""
    end

    @testset "illegal diagonal does not make a winner" begin
        board = [
            "X O . .",
            " O X X X",
            "  O X O .",
            "   . O X .",
            "    X X O O"
        ]
        @test connect(board) == ""
    end

    @testset "nobody wins crossing adjacent angles" begin
        board = [
            "X . . .",
            " . X O .",
            "  O . X O",
            "   . O . X",
            "    . . O ."
        ]
        @test connect(board) == ""
    end

    @testset "X wins crossing from left to right" begin
        board = [
            ". O . .",
            " O X X X",
            "  O X O .",
            "   X X O X",
            "    . O X ."
        ]
        @test connect(board) == "X"
    end

    @testset "O wins crossing from top to bottom" begin
        board = [
            ". O . .",
            " O X X X",
            "  O O O .",
            "   X X O X",
            "    . O X ."
        ]
        @test connect(board) == "O"
    end

    @testset "X wins using a convoluted path" begin
        board = [
            ". X X . .",
            " X . X . X",
            "  . X . X .",
            "   . X X . .",
            "    O O O O O"
        ]
        @test connect(board) == "X"
    end

    @testset "X wins using a spiral path" begin
        board = [
            "O X X X X X X X X",
            " O X O O O O O O O",
            "  O X O X X X X X O",
            "   O X O X O O O X O",
            "    O X O X X X O X O",
            "     O X O O O X O X O",
            "      O X X X X X O X O",
            "       O O O O O O O X O",
            "        X X X X X X X X O"
        ]
        @test connect(board) == "X"
    end
end
