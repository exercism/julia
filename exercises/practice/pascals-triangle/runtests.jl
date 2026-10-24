# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/pascals-triangle/canonical-data.json
# File last updated on 2026-10-24

using Test

include("pascals-triangle.jl")

@testset verbose = true "tests" begin
    @testset "zero rows" begin
        @test triangle(0) == []
    end

    @testset "single row" begin
        @test triangle(1) == [[1]]
    end

    @testset "two rows" begin
        @test triangle(2) == [[1], [1, 1]]
    end

    @testset "three rows" begin
        @test triangle(3) == [[1], [1, 1], [1, 2, 1]]
    end

    @testset "four rows" begin
        @test triangle(4) == [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1]]
    end

    @testset "five rows" begin
        @test triangle(5) == [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1]]
    end

    @testset "six rows" begin
        @test triangle(6) ==
              [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1], [1, 5, 10, 10, 5, 1]]
    end

    @testset "ten rows" begin
        @test triangle(10) ==
              [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1], [1, 4, 6, 4, 1], [1, 5, 10, 10, 5, 1],
               [1, 6, 15, 20, 15, 6, 1], [1, 7, 21, 35, 35, 21, 7, 1],
               [1, 8, 28, 56, 70, 56, 28, 8, 1], [1, 9, 36, 84, 126, 126, 84, 36, 9, 1]]
    end
end
