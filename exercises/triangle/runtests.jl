using Base.Test

include("triangle.jl")

@testset "check equilateral triangles" begin
    @testset "true if all sides are equal" begin
        @test is_equilateral([2, 2, 2]) == true
        @test is_equilateral([0.5, 0.5, 0.5]) == true
    end

    @testset "false if any side is unequal" begin
        @test is_equilateral([2, 3, 2]) == false
    end

    @testset "false if no sides are equal" begin
        @test is_equilateral([5, 4, 6]) == false
    end

    @testset "false if invalid triangle" begin
        @test is_equilateral([0, 0, 0]) == false
    end
end

@testset "check isosceles triangles" begin
    @testset "true if at least 2 sides are equal" begin
        @test is_isosceles([3, 4, 4]) == true
        @test is_isosceles([4, 3, 4]) == true
        @test is_isosceles([4, 4, 3]) == true
        @test is_isosceles([4, 4, 4]) == true
        @test is_isosceles([0.4, 0.5, 0.5]) == true
        @test is_isosceles([0.5, 0.4, 0.5]) == true
        @test is_isosceles([0.5, 0.5, 0.4]) == true
    end

    @testset "false if no sides are equal" begin
        @test is_isosceles([2, 3, 4]) == false
    end

    @testset "false if invalid triangle" begin
        @test is_isosceles([1, 1, 3]) == false
    end
end


@testset "check scalene triangles" begin
    @testset "true if no sides are equal" begin
        @test is_scalene([5, 4, 6]) == true
        @test is_scalene([0.5, 0.4, 0.6]) == true
    end

    @testset "false if at least 2 sides are equal" begin
        @test is_scalene([3, 4, 4]) == false
        @test is_scalene([4, 3, 4]) == false
        @test is_scalene([4, 4, 3]) == false
        @test is_scalene([4, 4, 4]) == false
        @test is_scalene([0.4, 0.5, 0.5]) == false
        @test is_scalene([0.5, 0.4, 0.5]) == false
        @test is_scalene([0.5, 0.5, 0.4]) == false
    end

    @testset "false if invalid triangle" begin
        @test is_scalene([7, 3, 2]) == false
    end
end
