# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/reverse-string/canonical-data.json
# File last updated on 2026-10-23

using Test

include("reverse-string.jl")

@testset verbose = true "tests" begin
    @testset "an empty string" begin
        @test myreverse("") == ""
    end

    @testset "a word" begin
        @test myreverse("robot") == "tobor"
    end

    @testset "a capitalized word" begin
        @test myreverse("Ramen") == "nemaR"
    end

    @testset "a sentence with punctuation" begin
        @test myreverse("I'm hungry!") == "!yrgnuh m'I"
    end

    @testset "a palindrome" begin
        @test myreverse("racecar") == "racecar"
    end

    @testset "an even-sized word" begin
        @test myreverse("drawer") == "reward"
    end

    @testset "wide characters" begin
        @test myreverse("子猫") == "猫子"
    end

    # Bonus tasks: enabled by adding `const TEST_GRAPHEMES = true` to the solution file
    if @isdefined(TEST_GRAPHEMES)
        @eval @testset "graphemes" begin
            @testset "grapheme cluster with pre-combined form" begin
                @test myreverse("Würstchenstand") == "dnatsnehctsrüW"
            end

            @testset "grapheme clusters" begin
                @test myreverse("ผู้เขียนโปรแกรม") == "มรกแรปโนยขีเผู้"
            end
        end
    end
end
