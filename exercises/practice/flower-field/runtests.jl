# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/flower-field/canonical-data.json
# File last updated on 2026-10-24

using Test

include("flower-field.jl")

@testset verbose = true "tests" begin
    @testset "no rows" begin
        @test annotate(String[]) == []
    end

    @testset "no columns" begin
        @test annotate([""]) == [""]
    end

    @testset "no flowers" begin
        @test annotate(["   ", "   ", "   "]) == ["   ", "   ", "   "]
    end

    @testset "garden full of flowers" begin
        @test annotate(["***", "***", "***"]) == ["***", "***", "***"]
    end

    @testset "flower surrounded by spaces" begin
        @test annotate(["   ", " * ", "   "]) == ["111", "1*1", "111"]
    end

    @testset "space surrounded by flowers" begin
        @test annotate(["***", "* *", "***"]) == ["***", "*8*", "***"]
    end

    @testset "horizontal line" begin
        @test annotate([" * * "]) == ["1*2*1"]
    end

    @testset "horizontal line, flowers at edges" begin
        @test annotate(["*   *"]) == ["*1 1*"]
    end

    @testset "vertical line" begin
        @test annotate([" ", "*", " ", "*", " "]) == ["1", "*", "2", "*", "1"]
    end

    @testset "vertical line, flowers at edges" begin
        @test annotate(["*", " ", " ", " ", "*"]) == ["*", "1", " ", "1", "*"]
    end

    @testset "cross" begin
        @test annotate(["  *  ", "  *  ", "*****", "  *  ", "  *  "]) ==
              [" 2*2 ", "25*52", "*****", "25*52", " 2*2 "]
    end

    @testset "large garden" begin
        @test annotate([" *  * ", "  *   ", "    * ", "   * *", " *  * ", "      "]) ==
              ["1*22*1", "12*322", " 123*2", "112*4*", "1*22*2", "111111"]
    end

    @testset "multiple adjacent flowers" begin
        @test annotate([" ** "]) == ["1**1"]
    end
end
