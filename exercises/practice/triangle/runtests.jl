# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/triangle/canonical-data.json
# File last updated on 2026-10-24

using Test

include("triangle.jl")

@testset verbose = true "tests" begin
    @testset "equilateral triangle" begin
        @testset "all sides are equal" begin
            @test is_equilateral([2, 2, 2])
        end

        @testset "any side is unequal" begin
            @test !is_equilateral([2, 3, 2])
        end

        @testset "no sides are equal" begin
            @test !is_equilateral([5, 4, 6])
        end

        @testset "all zero sides is not a triangle" begin
            @test !is_equilateral([0, 0, 0])
        end

        @testset "sides may be floats" begin
            @test is_equilateral([0.5, 0.5, 0.5])
        end
    end

    @testset "isosceles triangle" begin
        @testset "last two sides are equal" begin
            @test is_isosceles([3, 4, 4])
        end

        @testset "first two sides are equal" begin
            @test is_isosceles([4, 4, 3])
        end

        @testset "first and last sides are equal" begin
            @test is_isosceles([4, 3, 4])
        end

        @testset "equilateral triangles are also isosceles" begin
            @test is_isosceles([4, 4, 4])
        end

        @testset "no sides are equal" begin
            @test !is_isosceles([2, 3, 4])
        end

        @testset "first triangle inequality violation" begin
            @test !is_isosceles([1, 1, 3])
        end

        @testset "second triangle inequality violation" begin
            @test !is_isosceles([1, 3, 1])
        end

        @testset "third triangle inequality violation" begin
            @test !is_isosceles([3, 1, 1])
        end

        @testset "sides may be floats" begin
            @test is_isosceles([0.5, 0.4, 0.5])
        end
    end

    @testset "scalene triangle" begin
        @testset "no sides are equal" begin
            @test is_scalene([5, 4, 6])
        end

        @testset "all sides are equal" begin
            @test !is_scalene([4, 4, 4])
        end

        @testset "first and second sides are equal" begin
            @test !is_scalene([4, 4, 3])
        end

        @testset "first and third sides are equal" begin
            @test !is_scalene([3, 4, 3])
        end

        @testset "second and third sides are equal" begin
            @test !is_scalene([4, 3, 3])
        end

        @testset "may not violate triangle inequality" begin
            @test !is_scalene([7, 3, 2])
        end

        @testset "sides may be floats" begin
            @test is_scalene([0.5, 0.4, 0.6])
        end
    end
end
