# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/rna-transcription/canonical-data.json
# File last updated on 2026-10-22

using Test

include("rna-transcription.jl")

@testset verbose = true "tests" begin
    @testset "Empty RNA sequence" begin
        @test to_rna("") == ""
    end

    @testset "RNA complement of cytosine is guanine" begin
        @test to_rna("C") == "G"
    end

    @testset "RNA complement of guanine is cytosine" begin
        @test to_rna("G") == "C"
    end

    @testset "RNA complement of thymine is adenine" begin
        @test to_rna("T") == "A"
    end

    @testset "RNA complement of adenine is uracil" begin
        @test to_rna("A") == "U"
    end

    @testset "RNA complement" begin
        @test to_rna("ACGTGGTCTTAA") == "UGCACCAGAAUU"
    end
end
