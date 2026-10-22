# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/leap/canonical-data.json
# File last updated on 2026-10-22

using Test

include("leap.jl")

@testset verbose = true "tests" begin
    @testset "year not divisible by 4 in common year" begin
        @test !is_leap_year(2015)
    end

    @testset "year divisible by 2, not divisible by 4 in common year" begin
        @test !is_leap_year(1970)
    end

    @testset "year divisible by 4, not divisible by 100 in leap year" begin
        @test is_leap_year(1996)
    end

    @testset "year divisible by 4 and 5 is still a leap year" begin
        @test is_leap_year(1960)
    end

    @testset "year divisible by 100, not divisible by 400 in common year" begin
        @test !is_leap_year(2100)
    end

    @testset "year divisible by 100 but not by 3 is still not a leap year" begin
        @test !is_leap_year(1900)
    end

    @testset "year divisible by 400 is leap year" begin
        @test is_leap_year(2000)
    end

    @testset "year divisible by 400 but not by 125 is still a leap year" begin
        @test is_leap_year(2400)
    end

    @testset "year divisible by 200, not divisible by 400 in common year" begin
        @test !is_leap_year(1800)
    end

    @testset "year divisible by 4, not divisible by 100 in leap year (2016)" begin
        @test is_leap_year(2016)
    end
end
