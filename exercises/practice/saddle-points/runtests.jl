# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/saddle-points/canonical-data.json
# File last updated on 2026-10-24

using Test

include("saddle-points.jl")

@testset verbose = true "tests" begin
    @testset "Can identify single saddle point" begin
        @test sort(saddlepoints([9 8 7; 5 3 2; 6 6 7])) == [(2, 1)]
    end

    @testset "Can identify that empty matrix has no saddle points" begin
        @test sort(saddlepoints(Matrix{Int}(undef, 0, 0))) == []
    end

    @testset "Can identify lack of saddle points when there are none" begin
        @test sort(saddlepoints([1 2 3; 3 1 2; 2 3 1])) == []
    end

    @testset "Can identify multiple saddle points in a column" begin
        @test sort(saddlepoints([4 5 4; 3 5 5; 1 5 4])) == [(1, 2), (2, 2), (3, 2)]
    end

    @testset "Can identify multiple saddle points in a row" begin
        @test sort(saddlepoints([6 7 8; 5 5 5; 7 5 6])) == [(2, 1), (2, 2), (2, 3)]
    end

    @testset "Can identify saddle point in bottom right corner" begin
        @test sort(saddlepoints([8 7 9; 6 7 6; 3 2 5])) == [(3, 3)]
    end

    @testset "Can identify saddle points in a non square matrix" begin
        @test sort(saddlepoints([3 1 3; 3 2 4])) == [(1, 1), (1, 3)]
    end

    @testset "Can identify that saddle points in a single column matrix are those with the minimum value" begin
        @test sort(saddlepoints(reshape([2, 1, 4, 1], :, 1))) == [(2, 1), (4, 1)]
    end

    @testset "Can identify that saddle points in a single row matrix are those with the maximum value" begin
        @test sort(saddlepoints([2 5 3 5])) == [(1, 2), (1, 4)]
    end
end
