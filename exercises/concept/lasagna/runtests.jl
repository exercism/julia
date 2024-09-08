using Test

include("lasagna.jl")

@testset verbose = true "tests" begin
    
    @testset "expected bake time" begin
        @test expected_bake_time == 60
        @test isconst(typeof(expected_bake_time), expected_bake_time) == true
    end
    
    @testset "preparation time" begin
        @test preptime(2) == 4
        @test preptime(3) == 6
        @test preptime(8) == 16
    end

    @testset "remaining time" begin
        @test remaining_time(30) == 30
        @test remaining_time(50) == 10
        @test remaining_time(60) == 0
    end

    @testset "total working time" begin
        @test total_working_time(3, 20) == 26
    end
end
