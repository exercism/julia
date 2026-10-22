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

    @testset "identical medium strands" begin
        @test distance("GGACTGA", "GGACTGA") == 0
    end

    @testset "single letter complete distance" begin
        @test distance("A", "G") == 1
    end

    @testset "small complete distance" begin
        @test distance("AG", "CT") == 2
    end

    @testset "small distance in first position" begin
        @test distance("AT", "CT") == 1
    end

    @testset "small distance in middle" begin
        @test distance("GGACG", "GGTCG") == 1
    end

    @testset "small distance in long strands" begin
        @test distance("ACCAGGG", "ACTATGG") == 2
    end

    @testset "non-unique characters in first strand" begin
        @test distance("AGA", "AGG") == 1
    end

    @testset "non-unique characters in second strand" begin
        @test distance("AGG", "AGA") == 1
    end

    @testset "same nucleotides in different positions" begin
        @test distance("TAG", "GAT") == 2
    end

    @testset "large distance" begin
        @test distance("GATACA", "GCATAA") == 4
    end
end
