# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/line-up/canonical-data.json
# File last updated on 2026-07-27

using Test

include("line-up.jl")

@testset verbose = true "tests" begin
    @testset "format smallest non-exceptional ordinal numeral 4" begin
        @test line_up("Gianna", 4) ==
              "Gianna, you are the 4th customer we serve today. Thank you!"
    end

    @testset "format greatest single digit non-exceptional ordinal numeral 9" begin
        @test line_up("Maarten", 9) ==
              "Maarten, you are the 9th customer we serve today. Thank you!"
    end

    @testset "format non-exceptional ordinal numeral 5" begin
        @test line_up("Petronila", 5) ==
              "Petronila, you are the 5th customer we serve today. Thank you!"
    end

    @testset "format non-exceptional ordinal numeral 6" begin
        @test line_up("Attakullakulla", 6) ==
              "Attakullakulla, you are the 6th customer we serve today. Thank you!"
    end

    @testset "format non-exceptional ordinal numeral 7" begin
        @test line_up("Kate", 7) ==
              "Kate, you are the 7th customer we serve today. Thank you!"
    end

    @testset "format non-exceptional ordinal numeral 8" begin
        @test line_up("Maximiliano", 8) ==
              "Maximiliano, you are the 8th customer we serve today. Thank you!"
    end

    @testset "format exceptional ordinal numeral 1" begin
        @test line_up("Mary", 1) ==
              "Mary, you are the 1st customer we serve today. Thank you!"
    end

    @testset "format exceptional ordinal numeral 2" begin
        @test line_up("Haruto", 2) ==
              "Haruto, you are the 2nd customer we serve today. Thank you!"
    end

    @testset "format exceptional ordinal numeral 3" begin
        @test line_up("Henriette", 3) ==
              "Henriette, you are the 3rd customer we serve today. Thank you!"
    end

    @testset "format smallest two digit non-exceptional ordinal numeral 10" begin
        @test line_up("Alvarez", 10) ==
              "Alvarez, you are the 10th customer we serve today. Thank you!"
    end

    @testset "format non-exceptional ordinal numeral 11" begin
        @test line_up("Jacqueline", 11) ==
              "Jacqueline, you are the 11th customer we serve today. Thank you!"
    end

    @testset "format non-exceptional ordinal numeral 12" begin
        @test line_up("Juan", 12) ==
              "Juan, you are the 12th customer we serve today. Thank you!"
    end

    @testset "format non-exceptional ordinal numeral 13" begin
        @test line_up("Patricia", 13) ==
              "Patricia, you are the 13th customer we serve today. Thank you!"
    end

    @testset "format exceptional ordinal numeral 21" begin
        @test line_up("Washi", 21) ==
              "Washi, you are the 21st customer we serve today. Thank you!"
    end

    @testset "format exceptional ordinal numeral 62" begin
        @test line_up("Nayra", 62) ==
              "Nayra, you are the 62nd customer we serve today. Thank you!"
    end

    @testset "format exceptional ordinal numeral 100" begin
        @test line_up("John", 100) ==
              "John, you are the 100th customer we serve today. Thank you!"
    end

    @testset "format exceptional ordinal numeral 101" begin
        @test line_up("Zeinab", 101) ==
              "Zeinab, you are the 101st customer we serve today. Thank you!"
    end

    @testset "format non-exceptional ordinal numeral 112" begin
        @test line_up("Knud", 112) ==
              "Knud, you are the 112th customer we serve today. Thank you!"
    end

    @testset "format exceptional ordinal numeral 123" begin
        @test line_up("Yma", 123) ==
              "Yma, you are the 123rd customer we serve today. Thank you!"
    end
end
