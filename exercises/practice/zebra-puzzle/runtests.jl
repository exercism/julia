# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/zebra-puzzle/canonical-data.json
# File last updated on 2026-11-10

using Test

include("zebra-puzzle.jl")

@testset verbose = true "tests" begin
    @testset "resident who drinks water" begin
        @test drinkswater() == "Norwegian"
    end

    @testset "resident who owns zebra" begin
        @test ownszebra() == "Japanese"
    end
end
