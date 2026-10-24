# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/killer-sudoku-helper/canonical-data.json
# File last updated on 2026-10-24

using Test

include("sudoku-util.jl")

@testset verbose = true "tests" begin
    @testset "Trivial 1-digit cages" begin
        @testset "1" begin
            @test combinations_in_cage(1, 1) == [[1]]
        end

        @testset "2" begin
            @test combinations_in_cage(2, 1) == [[2]]
        end

        @testset "3" begin
            @test combinations_in_cage(3, 1) == [[3]]
        end

        @testset "4" begin
            @test combinations_in_cage(4, 1) == [[4]]
        end

        @testset "5" begin
            @test combinations_in_cage(5, 1) == [[5]]
        end

        @testset "6" begin
            @test combinations_in_cage(6, 1) == [[6]]
        end

        @testset "7" begin
            @test combinations_in_cage(7, 1) == [[7]]
        end

        @testset "8" begin
            @test combinations_in_cage(8, 1) == [[8]]
        end

        @testset "9" begin
            @test combinations_in_cage(9, 1) == [[9]]
        end
    end

    @testset "Cage with sum 45 contains all digits 1:9" begin
        @test combinations_in_cage(45, 9) == [[1, 2, 3, 4, 5, 6, 7, 8, 9]]
    end

    @testset "Cage with only 1 possible combination" begin
        @test combinations_in_cage(7, 3) == [[1, 2, 4]]
    end

    @testset "Cage with several combinations" begin
        @test combinations_in_cage(10, 2) == [[1, 9], [2, 8], [3, 7], [4, 6]]
    end

    @testset "Cage with several combinations that is restricted" begin
        @test combinations_in_cage(10, 2, [1, 4]) == [[2, 8], [3, 7]]
    end
end
