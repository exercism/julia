using Test

include("triangle.jl")

@testset "check equilateral triangles" begin
    @testset "true if all sides are equal" begin
        @test is_equilateral([2, 2, 2])
        @test is_equilateral([0.5, 0.5, 0.5])
    end

    @testset "false if any side is unequal" begin
        @test !is_equilateral([2, 3, 2])
    end

    @testset "false if no sides are equal" begin
        @test !is_equilateral([5, 4, 6])
    end

    @testset "false if invalid triangle" begin
        @test !is_equilateral([0, 0, 0])
    end
end

@testset "check isosceles triangles" begin
    @testset "true if at least 2 sides are equal" begin
        @test is_isosceles([3, 4, 4])
        @test is_isosceles([4, 3, 4])
        @test is_isosceles([4, 4, 3])
        @test is_isosceles([4, 4, 4])
        @test is_isosceles([0.4, 0.5, 0.5])
        @test is_isosceles([0.5, 0.4, 0.5])
        @test is_isosceles([0.5, 0.5, 0.4])
    end

    @testset "false if no sides are equal" begin
        @test !is_isosceles([2, 3, 4])
    end

    @testset "false if invalid triangle" begin
        @test !is_isosceles([1, 1, 3])
    end
end


@testset "check scalene triangles" begin
    @testset "true if no sides are equal" begin
        @test is_scalene([5, 4, 6]) == true
        @test is_scalene([0.5, 0.4, 0.6]) == true
    end

    @testset "false if at least 2 sides are equal" begin
        @test !is_scalene([3, 4, 4])
        @test !is_scalene([4, 3, 4])
        @test !is_scalene([4, 4, 3])
        @test !is_scalene([4, 4, 4])
        @test !is_scalene([0.4, 0.5, 0.5])
        @test !is_scalene([0.5, 0.4, 0.5])
        @test !is_scalene([0.5, 0.5, 0.4])
    end

    @testset "false if invalid triangle" begin
        @test !is_scalene([7, 3, 2])
    end
end
