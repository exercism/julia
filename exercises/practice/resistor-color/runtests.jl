# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/resistor-color/canonical-data.json
# File last updated on 2026-10-24

using Test

include("resistor-color.jl")

@testset verbose = true "tests" begin
    @testset "Color codes" begin
        @testset "Black" begin
            @test colorcode("black") == 0
        end

        @testset "White" begin
            @test colorcode("white") == 9
        end

        @testset "Orange" begin
            @test colorcode("orange") == 3
        end
    end

    @testset "Colors" begin
        @test collect(colors()) ==
              ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet",
               "grey", "white"]
    end
end
