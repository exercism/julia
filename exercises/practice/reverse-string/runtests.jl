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

    @testset "reversing a string twice" begin
        @test myreverse(myreverse("gift")) == "gift"
    end

    @testset "emoji" begin
        @test myreverse("hi 🐱") == "🐱 ih"
    end

    @testset "wide characters" begin
        @test myreverse("子猫") == "猫子"
    end

    if @isdefined(TEST_GRAPHEMES)
        @eval @testset "graphemes" begin
            @test myreverse("as⃝df̅") == "f̅ds⃝a"
            @test myreverse("hi 👋🏾") == "👋🏾 ih"
            @test myreverse("Würstchenstand") == "dnatsnehctsrüW"
            @test myreverse("ผู้เขียนโปรแกรม") == "มรกแรปโนยขีเผู้"
        end
    end
end
