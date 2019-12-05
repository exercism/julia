# canonical data version: 1.2.0

using Test

include("reverse-string.jl")


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
