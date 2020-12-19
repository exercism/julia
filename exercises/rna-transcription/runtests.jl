using Test

include("rna-transcription.jl")

@testset "basic transformations" begin
    @testset "empty rna sequence" begin
        @test to_rna("") == ""
    end

    @testset "rna complement of cytosine is guanine" begin
        @test to_rna("C") == "G"
    end

    @testset "rna complement of guanine is cytosine" begin
        @test to_rna("G") == "C"
    end

    @testset "rna complement of thymine is adenine" begin
        @test to_rna("T") == "A"
    end

    @testset "rna complement of adenine is uracil" begin
        @test to_rna("A") == "U"
    end
end

@testset "rna complement" begin
    @test to_rna("ACGTGGTCTTAA") == "UGCACCAGAAUU"
end

@testset "error handling" begin
    @testset "dna correctly handles invalid input" begin
        @test_throws ErrorException to_rna("U")
    end

    @testset "dna correctly handles completely invalid input" begin
        @test_throws ErrorException to_rna("XXX")
    end

    @testset "dna correctly handles partially invalid input" begin
        @test_throws ErrorException to_rna("ACGTXXXCTTAA")
    end
end
