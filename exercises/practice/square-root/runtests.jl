# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/square-root/canonical-data.json
# File last updated on 2026-10-23

using Test

include("square-root.jl")

@testset verbose = true "tests" begin
    @testset "root of 1" begin
        @test square_root(1) == 1
    end

    @testset "root of 4" begin
        @test square_root(4) == 2
    end

    @testset "root of 25" begin
        @test square_root(25) == 5
    end

    @testset "root of 81" begin
        @test square_root(81) == 9
    end

    @testset "root of 196" begin
        @test square_root(196) == 14
    end

    @testset "root of 65025" begin
        @test square_root(65025) == 255
    end
end
