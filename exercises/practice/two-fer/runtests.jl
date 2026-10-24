# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/two-fer/canonical-data.json
# File last updated on 2026-10-24

using Test

include("two-fer.jl")

@testset verbose = true "tests" begin
    @testset "no name given" begin
        @test twofer() == "One for you, one for me."
    end

    @testset "a name given" begin
        @test twofer("Alice") == "One for Alice, one for me."
    end

    @testset "another name given" begin
        @test twofer("Bob") == "One for Bob, one for me."
    end
end
