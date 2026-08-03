# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/rectangles/canonical-data.json
# File last updated on 2026-08-02

using Test

include("rectangles.jl")

@testset verbose = true "tests" begin
    @testset "no rows" begin
        @test rectangles([]) == 0
    end

    @testset "no columns" begin
        @test rectangles([""]) == 0
    end

    @testset "no rectangles" begin
        @test rectangles([" "]) == 0
    end

    @testset "one rectangle" begin
        @test rectangles(["+-+", "| |", "+-+"]) == 1
    end

    @testset "two rectangles without shared parts" begin
        @test rectangles(["  +-+", "  | |", "+-+-+", "| |  ", "+-+  "]) == 2
    end

    @testset "five rectangles with shared parts" begin
        @test rectangles(["  +-+", "  | |", "+-+-+", "| | |", "+-+-+"]) == 5
    end

    @testset "rectangle of height 1 is counted" begin
        @test rectangles(["+--+", "+--+"]) == 1
    end

    @testset "rectangle of width 1 is counted" begin
        @test rectangles(["++", "||", "++"]) == 1
    end

    @testset "1x1 square is counted" begin
        @test rectangles(["++", "++"]) == 1
    end

    @testset "only complete rectangles are counted" begin
        @test rectangles(["  +-+", "    |", "+-+-+", "| | -", "+-+-+"]) == 1
    end

    @testset "rectangles can be of different sizes" begin
        @test rectangles(["+------+----+", "|      |    |", "+---+--+    |",
                          "|   |       |", "+---+-------+"]) == 3
    end

    @testset "corner is required for a rectangle to be complete" begin
        @test rectangles(["+------+----+", "|      |    |", "+------+    |",
                          "|   |       |", "+---+-------+"]) == 2
    end

    @testset "large input with many rectangles" begin
        @test rectangles(["+---+--+----+", "|   +--+----+", "+---+--+    |",
                          "|   +--+----+", "+---+--+--+-+", "+---+--+--+-+",
                          "+------+  | |", "          +-+"]) == 60
    end

    @testset "rectangles must have four sides" begin
        @test rectangles(["+-+ +-+", "| | | |", "+-+-+-+", "  | |  ", "+-+-+-+", "| | | |",
                          "+-+ +-+"]) == 5
    end
end
