# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/queen-attack/canonical-data.json
# File last updated on 2026-10-24

using Test

include("queen-attack.jl")

@testset verbose = true "tests" begin
    @testset "Test creation of Queens with valid and invalid positions" begin
        @testset "queen with a valid position" begin
            @test Queen(2, 2) isa Queen
        end

        @testset "queen must have positive row" begin
            @test_throws InvalidPosition Queen(-2, 2)
        end

        @testset "queen must have row on board" begin
            @test_throws InvalidPosition Queen(8, 4)
        end

        @testset "queen must have positive column" begin
            @test_throws InvalidPosition Queen(2, -2)
        end

        @testset "queen must have column on board" begin
            @test_throws InvalidPosition Queen(4, 8)
        end
    end

    @testset "Test the ability of one queen to attack another" begin
        @testset "cannot attack" begin
            @test !canattack(Queen(2, 4), Queen(6, 6))
        end

        @testset "can attack on same row" begin
            @test canattack(Queen(2, 4), Queen(2, 6))
        end

        @testset "can attack on same column" begin
            @test canattack(Queen(4, 5), Queen(2, 5))
        end

        @testset "can attack on first diagonal" begin
            @test canattack(Queen(2, 2), Queen(0, 4))
        end

        @testset "can attack on second diagonal" begin
            @test canattack(Queen(2, 2), Queen(3, 1))
        end

        @testset "can attack on third diagonal" begin
            @test canattack(Queen(2, 2), Queen(1, 1))
        end

        @testset "can attack on fourth diagonal" begin
            @test canattack(Queen(1, 7), Queen(0, 6))
        end

        @testset "cannot attack if falling diagonals are only the same when reflected across the longest falling diagonal" begin
            @test !canattack(Queen(4, 1), Queen(2, 5))
        end
    end
end
