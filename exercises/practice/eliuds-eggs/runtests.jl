# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/eliuds-eggs/canonical-data.json
# File last updated on 2026-10-22

using Test

include("eliuds-eggs.jl")

@testset verbose = true "tests" begin
    @testset "0 eggs" begin
        @test eggcount(0) == 0
    end

    @testset "1 egg" begin
        @test eggcount(16) == 1
    end

    @testset "4 eggs" begin
        @test eggcount(89) == 4
    end

    @testset "13 eggs" begin
        @test eggcount(2000000000) == 13
    end
end
