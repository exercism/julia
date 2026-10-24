# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/grains/canonical-data.json
# File last updated on 2026-10-23

using Test

include("grains.jl")

@testset verbose = true "tests" begin
    @testset "returns the number of grains on the square" begin
        @testset "grains on square 1" begin
            @test on_square(1) == 1
        end

        @testset "grains on square 2" begin
            @test on_square(2) == 2
        end

        @testset "grains on square 3" begin
            @test on_square(3) == 4
        end

        @testset "grains on square 4" begin
            @test on_square(4) == 8
        end

        @testset "grains on square 16" begin
            @test on_square(16) == 32768
        end

        @testset "grains on square 32" begin
            @test on_square(32) == 2147483648
        end

        @testset "grains on square 64" begin
            @test on_square(64) == 9223372036854775808
        end

        @testset "square 0 is invalid" begin
            @test_throws DomainError on_square(0)
        end

        @testset "negative square is invalid" begin
            @test_throws DomainError on_square(-1)
        end

        @testset "square greater than 64 is invalid" begin
            @test_throws DomainError on_square(65)
        end
    end

    @testset "returns the total number of grains on the board" begin
        @test total_after(64) == 18446744073709551615
    end
end
