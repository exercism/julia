# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/matching-brackets/canonical-data.json
# File last updated on 2026-10-22

using Test

include("matching-brackets.jl")

@testset verbose = true "tests" begin
    @testset "paired square brackets" begin
        @test matching_brackets("[]")
    end

    @testset "empty string" begin
        @test matching_brackets("")
    end

    @testset "unpaired brackets" begin
        @test !matching_brackets("[[")
    end

    @testset "wrong ordered brackets" begin
        @test !matching_brackets("}{")
    end

    @testset "wrong closing bracket" begin
        @test !matching_brackets("{]")
    end

    @testset "paired with whitespace" begin
        @test matching_brackets("{ }")
    end

    @testset "partially paired brackets" begin
        @test !matching_brackets("{[])")
    end

    @testset "simple nested brackets" begin
        @test matching_brackets("{[]}")
    end

    @testset "several paired brackets" begin
        @test matching_brackets("{}[]")
    end

    @testset "paired and nested brackets" begin
        @test matching_brackets("([{}({}[])])")
    end

    @testset "unopened closing brackets" begin
        @test !matching_brackets("{[)][]}")
    end

    @testset "unpaired and nested brackets" begin
        @test !matching_brackets("([{])")
    end

    @testset "paired and wrong nested brackets" begin
        @test !matching_brackets("[({]})")
    end

    @testset "paired and wrong nested brackets but innermost are correct" begin
        @test !matching_brackets("[({}])")
    end

    @testset "paired and incomplete brackets" begin
        @test !matching_brackets("{}[")
    end

    @testset "too many closing brackets" begin
        @test !matching_brackets("[]]")
    end

    @testset "early unexpected brackets" begin
        @test !matching_brackets(")()")
    end

    @testset "early mismatched brackets" begin
        @test !matching_brackets("{)()")
    end

    @testset "math expression" begin
        @test matching_brackets("(((185 + 223.85) * 15) - 543)/2")
    end

    @testset "complex latex expression" begin
        @test matching_brackets("\\left(\\begin{array}{cc} \\frac{1}{3} & x\\\\ \\mathrm{e}^{x} &... x^2 \\end{array}\\right)")
    end
end
