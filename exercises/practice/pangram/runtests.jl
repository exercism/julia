# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/pangram/canonical-data.json
# File last updated on 2026-10-22

using Test

include("pangram.jl")

@testset verbose = true "tests" begin
    @testset "empty sentence" begin
        @test !ispangram("")
    end

    @testset "perfect lower case" begin
        @test ispangram("abcdefghijklmnopqrstuvwxyz")
    end

    @testset "only lower case" begin
        @test ispangram("the quick brown fox jumps over the lazy dog")
    end

    @testset "missing the letter 'x'" begin
        @test !ispangram("a quick movement of the enemy will jeopardize five gunboats")
    end

    @testset "missing the letter 'h'" begin
        @test !ispangram("five boxing wizards jump quickly at it")
    end

    @testset "with underscores" begin
        @test ispangram("the_quick_brown_fox_jumps_over_the_lazy_dog")
    end

    @testset "with numbers" begin
        @test ispangram("the 1 quick brown fox jumps over the 2 lazy dogs")
    end

    @testset "missing letters replaced by numbers" begin
        @test !ispangram("7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog")
    end

    @testset "mixed case and punctuation" begin
        @test ispangram("\"Five quacking Zephyrs jolt my wax bed.\"")
    end

    @testset "a-m and A-M are 26 different characters but not a pangram" begin
        @test !ispangram("abcdefghijklm ABCDEFGHIJKLM")
    end

    @testset "another missing the letter 'x'" begin
        @test !ispangram("the quick brown fish jumps over the lazy dog")
    end

    @testset "upper and lower case versions of the same character should not be counted separately" begin
        @test !ispangram("the quick brown fox jumped over the lazy FOX")
    end

    @testset "pangram with more than 26 letters (if case sensitive)" begin
        @test ispangram("the 1 quick brown fox jumps Over the 2 lazy dogs")
    end

    @testset "an Arabic pangram is not an English pangram" begin
        @test !ispangram("The scholar and poet Al Farāhīdi wrote this Arabic pangram: صِف خَلقَ خَودِ كَمِثلِ الشَمسِ إِذ بَزَغَت — يَحظى الضَجيعُ بِها نَجلاءَ مِعطارِ")
    end
end
