# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/bob/canonical-data.json
# File last updated on 2026-07-28

using Test

include("bob.jl")

@testset verbose = true "tests" begin
    @testset "asking a question" begin
        @test bob("""Does this cryogenic chamber make me look fat?""") == "Sure."
    end

    @testset "shouting" begin
        @test bob("""WATCH OUT!""") == "Whoa, chill out!"
    end

    @testset "forceful question" begin
        @test bob("""WHAT'S GOING ON?""") == "Calm down, I know what I'm doing!"
    end

    @testset "silence" begin
        @test bob("""""") == "Fine. Be that way!"
    end

    @testset "stating something" begin
        @test bob("""Tom-ay-to, tom-aaaah-to.""") == "Whatever."
    end

    @testset "asking a numeric question" begin
        @test bob("""You are, what, like 15?""") == "Sure."
    end

    @testset "asking gibberish" begin
        @test bob("""fffbbcbeab?""") == "Sure."
    end

    @testset "question with no letters" begin
        @test bob("""4?""") == "Sure."
    end

    @testset "non-letters with question" begin
        @test bob(""":) ?""") == "Sure."
    end

    @testset "prattling on" begin
        @test bob("""Wait! Hang on. Are you going to be OK?""") == "Sure."
    end

    @testset "ending with whitespace" begin
        @test bob("""Okay if like my  spacebar  quite a bit?   """) == "Sure."
    end

    @testset "multiple line question" begin
        @test bob("""
Does this cryogenic chamber make
 me look fat?""") == "Sure."
    end

    @testset "shouting gibberish" begin
        @test bob("""FCECDFCAAB""") == "Whoa, chill out!"
    end

    @testset "shouting a statement containing a question mark" begin
        @test bob("""DO LIONS EAT PEOPLE? AHHHHH.""") == "Whoa, chill out!"
    end

    @testset "shouting numbers" begin
        @test bob("""1, 2, 3 GO!""") == "Whoa, chill out!"
    end

    @testset "shouting with no exclamation mark" begin
        @test bob("""I HATE THE DENTIST""") == "Whoa, chill out!"
    end

    @testset "prolonged silence" begin
        @test bob("""          """) == "Fine. Be that way!"
    end

    @testset "alternate silence" begin
        @test bob("""										""") == "Fine. Be that way!"
    end

    @testset "other whitespace" begin
        @test bob("""
   """) == "Fine. Be that way!"
    end

    @testset "no letters" begin
        @test bob("""1, 2, 3""") == "Whatever."
    end

    @testset "statement containing question mark" begin
        @test bob("""Ending with ? means a question.""") == "Whatever."
    end

    @testset "starting with whitespace" begin
        @test bob("""         hmmmmmmm...""") == "Whatever."
    end

    @testset "non-question ending with whitespace" begin
        @test bob("""This is a statement ending with whitespace      """) == "Whatever."
    end
end
