# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/armstrong-numbers/canonical-data.json
# File last updated on 2026-10-22

using Test

include("armstrong-numbers.jl")

@testset verbose = true "tests" begin
    @testset "Zero is an Armstrong number" begin
        @test isarmstrong(0)
    end

    @testset "Single-digit numbers are Armstrong numbers" begin
        @test isarmstrong(5)
    end

    @testset "There are no two-digit Armstrong numbers" begin
        @test !isarmstrong(10)
    end

    @testset "Three-digit number that is an Armstrong number" begin
        @test isarmstrong(153)
    end

    @testset "Three-digit number that is not an Armstrong number" begin
        @test !isarmstrong(100)
    end

    @testset "Four-digit number that is an Armstrong number" begin
        @test isarmstrong(9474)
    end

    @testset "Four-digit number that is not an Armstrong number" begin
        @test !isarmstrong(9475)
    end

    @testset "Seven-digit number that is an Armstrong number" begin
        @test isarmstrong(9926315)
    end

    @testset "Seven-digit number that is not an Armstrong number" begin
        @test !isarmstrong(9926314)
    end
end
