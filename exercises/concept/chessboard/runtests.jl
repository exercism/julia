using Test

include("chessboard.jl")

@testset verbose = true "tests" begin

    @testset "rank_range is a range from 1 to 8" begin
        result = rank_range()
        @test first(result) == 1
        @test last(result) == 8
        @test length(result) == 8
        @test typeof(result) == UnitRange{Int}
    end

    @testset "file_range is a range from 'A' to 'H'" begin
        result = file_range()
        @test first(result) == 'A'
        @test last(result) == 'H'
        @test length(result) == 8
        @test typeof(result) == StepRange{Char, Int}
    end

    @testset "ranks is a vector of integers from 1 to 8" begin
        @test ranks() == [1, 2, 3, 4, 5, 6, 7, 8]
    end

    @testset "files is a vector of characters from 'A' to 'H'" begin
        @test ranks() == [1, 2, 3, 4, 5, 6, 7, 8]
    end

end
