using Test

include("hamming.jl")

@testset "identical strands" begin
    @test distance("A", "A") == 0
    @test distance("GGACTGA", "GGACTGA") == 0
end

@testset "complete distance" begin
    @test distance("A", "G") == 1
    @test distance("AG", "CT") == 2
end

@testset "small distance" begin
    @test distance("AT", "CT") == 1
    @test distance("GGACG", "GGTCG") == 1
    @test distance("ACCAGGG", "ACTATGG") == 2
end

@testset "non-unique characters" begin
    @test distance("AGA", "AGG") == 1
    @test distance("AGG", "AGA") == 1
end

@testset "same nucleotides in different positions" begin
    @test distance("TAG", "GAT") == 2
end

@testset "large distance" begin
    @test distance("GATACA", "GCATAA") == 4
    @test distance("GGACGGATTCTG", "AGGACGGATTCT") == 9
end

@testset "empty strands" begin
    @test distance("", "") == 0
end

@testset "different strand lengths" begin
    @test_throws ArgumentError distance("AATG", "AAA")
    @test_throws ArgumentError distance("ATA", "AGTG")
end
