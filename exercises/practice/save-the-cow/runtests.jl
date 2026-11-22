# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/save-the-cow/canonical-data.json
# File last updated on 2026-11-22

using Test

include("save-the-cow.jl")

@testset verbose = true "tests" begin
    @testset "Initially 9 failures are allowed and no letters are guessed" begin
        game = new_game("loot")
        @test state(game) == ONGOING
        @test masked_word(game) == "____"
        @test remaining_failures(game) == 9
    end

    @testset "After 10 failures the game is over" begin
        game = new_game("loot")
        guess!(game, 'a')
        guess!(game, 'b')
        guess!(game, 'c')
        guess!(game, 'd')
        guess!(game, 'e')
        guess!(game, 'f')
        guess!(game, 'g')
        guess!(game, 'h')
        guess!(game, 'i')
        guess!(game, 'j')
        @test state(game) == LOSE
        @test masked_word(game) == "____"
        @test remaining_failures(game) == 0
    end

    @testset "Losing with several correct guesses" begin
        game = new_game("loot")
        guess!(game, 't')
        guess!(game, 'o')
        guess!(game, 'a')
        guess!(game, 'b')
        guess!(game, 'c')
        guess!(game, 'd')
        guess!(game, 'e')
        guess!(game, 'f')
        guess!(game, 'g')
        guess!(game, 'h')
        guess!(game, 'i')
        guess!(game, 'j')
        @test state(game) == LOSE
        @test masked_word(game) == "_oot"
        @test remaining_failures(game) == 0
    end

    @testset "Feeding a correct letter removes underscores" begin
        game = new_game("loot")
        guess!(game, 't')
        @test state(game) == ONGOING
        @test masked_word(game) == "___t"
        @test remaining_failures(game) == 9
    end

    @testset "Feeding a correct letter twice counts as a failure" begin
        game = new_game("loot")
        guess!(game, 't')
        guess!(game, 't')
        @test state(game) == ONGOING
        @test masked_word(game) == "___t"
        @test remaining_failures(game) == 8
    end

    @testset "Guessing a repeated letter reveals all instances" begin
        game = new_game("loot")
        guess!(game, 't')
        guess!(game, 't')
        guess!(game, 'o')
        @test state(game) == ONGOING
        @test masked_word(game) == "_oot"
        @test remaining_failures(game) == 8
    end

    @testset "Getting all the letters right makes for a win" begin
        game = new_game("loot")
        guess!(game, 't')
        guess!(game, 't')
        guess!(game, 'o')
        guess!(game, 'l')
        @test state(game) == WIN
        @test masked_word(game) == "loot"
        @test remaining_failures(game) == 8
    end

    @testset "Winning on the last guess is still a win" begin
        game = new_game("loot")
        guess!(game, 'a')
        guess!(game, 'b')
        guess!(game, 'c')
        guess!(game, 'd')
        guess!(game, 'e')
        guess!(game, 'f')
        guess!(game, 'g')
        guess!(game, 'h')
        guess!(game, 'i')
        guess!(game, 't')
        guess!(game, 'o')
        guess!(game, 'l')
        @test state(game) == WIN
        @test masked_word(game) == "loot"
        @test remaining_failures(game) == 0
    end

    @testset "Guessing after a lose is error" begin
        game = new_game("loot")
        guess!(game, 'a')
        guess!(game, 'b')
        guess!(game, 'c')
        guess!(game, 'd')
        guess!(game, 'e')
        guess!(game, 'f')
        guess!(game, 'g')
        guess!(game, 'h')
        guess!(game, 'i')
        guess!(game, 'j')
        @test_throws ErrorException guess!(game, 'k')
    end

    @testset "Guessing after a win is error" begin
        game = new_game("loot")
        guess!(game, 't')
        guess!(game, 'o')
        guess!(game, 'l')
        @test_throws ErrorException guess!(game, 'l')
    end
end
