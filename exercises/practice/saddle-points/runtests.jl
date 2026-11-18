# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/saddle-points/canonical-data.json
# File last updated on 2026-11-17

using Test

include("saddle-points.jl")

@testset verbose = true "tests" begin
    @testset "Can identify single saddle point" begin
        matrix = [9 8 7
                  5 3 2
                  6 6 7]
        expected = [(2, 1)]
        @test sort(saddlepoints(matrix)) == expected
    end

    @testset "Can identify that empty matrix has no saddle points" begin
        matrix = Int[;;]
        expected = []
        @test sort(saddlepoints(matrix)) == expected
    end

    @testset "Can identify lack of saddle points when there are none" begin
        matrix = [1 2 3
                  3 1 2
                  2 3 1]
        expected = []
        @test sort(saddlepoints(matrix)) == expected
    end

    @testset "Can identify multiple saddle points in a column" begin
        matrix = [4 5 4
                  3 5 5
                  1 5 4]
        expected = [(1, 2), (2, 2), (3, 2)]
        @test sort(saddlepoints(matrix)) == expected
    end

    @testset "Can identify multiple saddle points in a row" begin
        matrix = [6 7 8
                  5 5 5
                  7 5 6]
        expected = [(2, 1), (2, 2), (2, 3)]
        @test sort(saddlepoints(matrix)) == expected
    end

    @testset "Can identify saddle point in bottom right corner" begin
        matrix = [8 7 9
                  6 7 6
                  3 2 5]
        expected = [(3, 3)]
        @test sort(saddlepoints(matrix)) == expected
    end

    @testset "Can identify saddle points in a non square matrix" begin
        matrix = [3 1 3
                  3 2 4]
        expected = [(1, 1), (1, 3)]
        @test sort(saddlepoints(matrix)) == expected
    end

    @testset "Can identify that saddle points in a single column matrix are those with the minimum value" begin
        matrix = reshape([2, 1, 4, 1], :, 1)
        expected = [(2, 1), (4, 1)]
        @test sort(saddlepoints(matrix)) == expected
    end

    @testset "Can identify that saddle points in a single row matrix are those with the maximum value" begin
        matrix = [2 5 3 5]
        expected = [(1, 2), (1, 4)]
        @test sort(saddlepoints(matrix)) == expected
    end
end
