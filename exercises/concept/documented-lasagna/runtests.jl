using Test

include("lasagna.jl")

# Util function
function hasdocstring(f::Symbol)
    @eval !startswith(string(@doc $f), "No documentation found.")
end

@testset "solution still works" begin
    @test preptime(2) == 4
    @test preptime(3) == 6
    @test preptime(8) == 16
    @test remaining_time(30) == 30
    @test remaining_time(50) == 10
    @test remaining_time(60) == 0
    @test total_working_time(3, 20) == 26
end

@testset "preptime has a docstring" begin
    @test hasdocstring(:preptime)
end

@testset "remaining_time has a docstring" begin
    @test hasdocstring(:remaining_time)
end

@testset "total_working_time has a docstring" begin
    @test hasdocstring(:total_working_time)
end
