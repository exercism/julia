# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/difference-of-squares/canonical-data.json
# File last updated on 2026-10-25

using Test

include("difference-of-squares.jl")

@testset verbose = true "tests" begin
    @testset "Square the sum of the numbers up to the given number" begin
        @testset "square of sum 1" begin
            @test square_of_sum(1)::Integer == 1
        end

        @testset "square of sum 5" begin
            @test square_of_sum(5)::Integer == 225
        end

        @testset "square of sum 100" begin
            @test square_of_sum(100)::Integer == 25502500
        end
    end

    @testset "Sum the squares of the numbers up to the given number" begin
        @testset "sum of squares 1" begin
            @test sum_of_squares(1)::Integer == 1
        end

        @testset "sum of squares 5" begin
            @test sum_of_squares(5)::Integer == 55
        end

        @testset "sum of squares 100" begin
            @test sum_of_squares(100)::Integer == 338350
        end
    end

    @testset "Subtract sum of squares from square of sums" begin
        @testset "difference of squares 1" begin
            @test difference(1)::Integer == 0
        end

        @testset "difference of squares 5" begin
            @test difference(5)::Integer == 170
        end

        @testset "difference of squares 100" begin
            @test difference(100)::Integer == 25164150
        end
    end
end
