# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/hamming/canonical-data.json
# File last updated on 2026-10-22

using Test

include("hamming.jl")

@testset verbose = true "tests" begin
    @testset "empty strands" begin
        @test distance("", "") == 0
    end

    @testset "single letter identical strands" begin
        @test distance("A", "A") == 0
    end

    @testset "single letter different strands" begin
        @test distance("G", "T") == 1
    end

    @testset "long identical strands" begin
        @test distance("GGACTGAAATCTG", "GGACTGAAATCTG") == 0
    end

    @testset "long different strands" begin
        @test distance("GGACGGATTCTG", "AGGACGGATTCT") == 9
    end

    @testset "disallow first strand longer" begin
        @test_throws ArgumentError distance("AATG", "AAA")
    end

    @testset "disallow second strand longer" begin
        @test_throws ArgumentError distance("ATA", "AGTG")
    end

    @testset "disallow empty first strand" begin
        @test_throws ArgumentError distance("", "G")
    end

    @testset "disallow empty second strand" begin
        @test_throws ArgumentError distance("G", "")
    end
end
