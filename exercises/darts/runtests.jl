using Test

include("darts.jl")

@testset "Missed target" begin
    @test score(-9, 9) == 0
end

@testset "On the outer circle" begin
    @test score(0, 10) == 1
end

@testset "On the middle circle" begin
    @test score(-5, 0) == 5
end

@testset "On the inner circle" begin
    @test score(0, -1) == 10
end

@testset "Exactly on centre" begin
    @test score(0, 0) == 10
end

@testset "Near the centre" begin
    @test score(-0.1, -0.1) == 10
end

@testset "Just within the inner circle" begin
    @test score(0.7, 0.7) == 10
end

@testset "Just outside the inner circle" begin
    @test score(0.8, -0.8) == 5
end

@testset "Just within the middle circle" begin
    @test score(-3.5, 3.5) == 5
end

@testset "Just outside the middle circle" begin
    @test score(-3.6, -3.6) == 1
end

@testset "Just within the outer circle" begin
    @test score(-7.0, 7.0) == 1
end

@testset "Just outside the outer circle" begin
    @test score(7.1, -7.1) == 0
end

@testset "Asymmetric position between the inner and middle circles" begin
    @test score(0.5, -4) == 5
end

