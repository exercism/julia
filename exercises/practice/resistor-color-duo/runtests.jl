# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/resistor-color-duo/canonical-data.json
# File last updated on 2026-10-23

using Test

include("resistor-color-duo.jl")

@testset verbose = true "tests" begin
    @testset "Brown and black" begin
        @test colorcode(["brown", "black"]) == 10
    end

    @testset "Blue and grey" begin
        @test colorcode(["blue", "grey"]) == 68
    end

    @testset "Yellow and violet" begin
        @test colorcode(["yellow", "violet"]) == 47
    end

    @testset "White and red" begin
        @test colorcode(["white", "red"]) == 92
    end

    @testset "Orange and orange" begin
        @test colorcode(["orange", "orange"]) == 33
    end

    @testset "Ignore additional colors" begin
        @test colorcode(["green", "brown", "orange"]) == 51
    end

    @testset "Black and brown, one-digit" begin
        @test colorcode(["black", "brown"]) == 1
    end
end
