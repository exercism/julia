# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/game-of-life/canonical-data.json
# File last updated on 2026-10-24

using Test

include("game-of-life.jl")

@testset verbose = true "tests" begin
    @testset "empty matrix" begin
        @test gameoflife(Int[;;]) == Int[;;]
    end

    @testset "live cells with zero live neighbors die" begin
        @test gameoflife([0 0 0; 0 1 0; 0 0 0]) == [0 0 0; 0 0 0; 0 0 0]
    end

    @testset "live cells with only one live neighbor die" begin
        @test gameoflife([0 0 0; 0 1 0; 0 1 0]) == [0 0 0; 0 0 0; 0 0 0]
    end

    @testset "live cells with two live neighbors stay alive" begin
        @test gameoflife([1 0 1; 1 0 1; 1 0 1]) == [0 0 0; 1 0 1; 0 0 0]
    end

    @testset "live cells with three live neighbors stay alive" begin
        @test gameoflife([0 1 0; 1 0 0; 1 1 0]) == [0 0 0; 1 0 0; 1 1 0]
    end

    @testset "dead cells with three live neighbors become alive" begin
        @test gameoflife([1 1 0; 0 0 0; 1 0 0]) == [0 0 0; 1 1 0; 0 0 0]
    end

    @testset "live cells with four or more neighbors die" begin
        @test gameoflife([1 1 1; 1 1 1; 1 1 1]) == [1 0 1; 0 0 0; 1 0 1]
    end

    @testset "bigger matrix" begin
        @test gameoflife([1 1 0 1 1 0 0 0; 1 0 1 1 0 0 0 0; 1 1 1 0 0 1 1 1;
                          0 0 0 0 0 1 1 0; 1 0 0 0 1 1 0 0; 1 1 0 0 0 1 1 1;
                          0 0 1 0 1 0 0 1; 1 0 0 0 0 0 1 1]) ==
              [1 1 0 1 1 0 0 0; 0 0 0 0 0 1 1 0; 1 0 1 1 1 1 0 1; 1 0 0 0 0 0 0 1;
               1 1 0 0 1 0 0 1; 1 1 0 1 0 0 0 1; 1 0 0 0 0 0 0 0; 0 0 0 0 0 0 1 1]
    end
end
