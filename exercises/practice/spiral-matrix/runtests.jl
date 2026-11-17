# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/spiral-matrix/canonical-data.json
# File last updated on 2026-11-17

using Test

include("spiral-matrix.jl")

@testset verbose = true "tests" begin
    @testset "empty spiral" begin
        expected = Int[;;]
        @test spiral_matrix(0) == expected
    end

    @testset "trivial spiral" begin
        expected = reshape([1], :, 1)
        @test spiral_matrix(1) == expected
    end

    @testset "spiral of size 2" begin
        expected = [1 2
                    4 3]
        @test spiral_matrix(2) == expected
    end

    @testset "spiral of size 3" begin
        expected = [1 2 3
                    8 9 4
                    7 6 5]
        @test spiral_matrix(3) == expected
    end

    @testset "spiral of size 4" begin
        #! format: off
        expected = [ 1  2  3 4
                    12 13 14 5
                    11 16 15 6
                    10  9  8 7]
        #! format: on
        @test spiral_matrix(4) == expected
    end

    @testset "spiral of size 5" begin
        #! format: off
        expected = [ 1  2  3  4 5
                    16 17 18 19 6
                    15 24 25 20 7
                    14 23 22 21 8
                    13 12 11 10 9]
        #! format: on
        @test spiral_matrix(5) == expected
    end
end
