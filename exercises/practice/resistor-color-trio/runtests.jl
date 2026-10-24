# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/resistor-color-trio/canonical-data.json
# File last updated on 2026-10-24

using Test

include("resistor-color-trio.jl")

@testset verbose = true "tests" begin
    @testset "Orange and orange and black" begin
        @test label(["orange", "orange", "black"]) == "33 ohms"
    end

    @testset "Blue and grey and brown" begin
        @test label(["blue", "grey", "brown"]) == "680 ohms"
    end

    @testset "Red and black and red" begin
        @test label(["red", "black", "red"]) == "2 kiloohms"
    end

    @testset "Green and brown and orange" begin
        @test label(["green", "brown", "orange"]) == "51 kiloohms"
    end

    @testset "Yellow and violet and yellow" begin
        @test label(["yellow", "violet", "yellow"]) == "470 kiloohms"
    end

    @testset "Blue and violet and blue" begin
        @test label(["blue", "violet", "blue"]) == "67 megaohms"
    end

    @testset "Minimum possible value" begin
        @test label(["black", "black", "black"]) == "0 ohms"
    end

    @testset "Maximum possible value" begin
        @test label(["white", "white", "white"]) == "99 gigaohms"
    end

    @testset "First two colors make an invalid octal number" begin
        @test label(["black", "grey", "black"]) == "8 ohms"
    end

    @testset "Ignore extra colors" begin
        @test label(["blue", "green", "yellow", "orange"]) == "650 kiloohms"
    end
end
