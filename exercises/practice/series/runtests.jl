# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/series/canonical-data.json
# File last updated on 2026-11-21

using Test

include("series.jl")

@testset verbose = true "tests" begin
    @testset "slices of one from one" begin
        @test slices("1", 1) == ["1"]
    end

    @testset "slices of one from two" begin
        @test slices("12", 1) == ["1", "2"]
    end

    @testset "slices of two" begin
        @test slices("35", 2) == ["35"]
    end

    @testset "slices of two overlap" begin
        @test slices("9142", 2) == ["91", "14", "42"]
    end

    @testset "slices can include duplicates" begin
        @test slices("777777", 3) == ["777", "777", "777", "777"]
    end

    @testset "slices of a long series" begin
        @test slices("918493904243", 5) ==
              ["91849", "18493", "84939", "49390", "93904", "39042", "90424", "04243"]
    end

    @testset "slice length is too large" begin
        @test_throws ErrorException slices("12345", 6)
    end

    @testset "slice length is way too large" begin
        @test_throws ErrorException slices("12345", 42)
    end

    @testset "slice length cannot be zero" begin
        @test_throws ErrorException slices("12345", 0)
    end

    @testset "slice length cannot be negative" begin
        @test_throws ErrorException slices("123", -1)
    end

    @testset "empty series is invalid" begin
        @test_throws ErrorException slices("", 1)
    end
end
