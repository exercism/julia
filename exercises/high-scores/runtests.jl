# canonical data version 4.0.0

using Test

include("high-scores.jl")


@testset "List of scores" begin
    @test list([30, 50, 20, 70]) == [30, 50, 20, 70]
end

@testset "Latest score" begin
    @test latest([100, 0, 90, 30]) == 30
end

@testset "Personal best" begin
    @test personalBest([40, 100, 70]) == 100
end

@testset "Top 3 scores" begin
    @test personalTopThree([10, 30, 90, 30, 100, 20, 10, 0, 30, 40, 40, 70, 70]) == [100, 90, 70]
end

@testset "Personal top highest to lowest" begin
    @test personalTopThree([20, 10, 30]) == [30, 20, 10]
end

@testset "Personal top when there is a tie" begin
    @test personalTopThree([40, 20, 40, 30]) == [40, 40, 30]
end

@testset "Personal top when there are less than 3" begin
    @test personalTopThree([30, 70]) == [70, 30]
end

@testset "Personal top when there is only one" begin
    @test personalTopThree([40]) == [40]
end
