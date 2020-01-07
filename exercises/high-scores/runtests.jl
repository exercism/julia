# canonical data version 4.0.0

using Test

include("high-scores.jl")


@testset "List of scores" begin
    @test scores([30, 50, 20, 70]) == [30, 50, 20, 70]
end

@testset "Latest score" begin
    @test scores([100, 0, 90, 30], latest=true) == 30
end

@testset "Personal best" begin
    @test scores([40, 100, 70], top=1) == 100
end

@testset "Top 3 scores" begin
    @test scores([10, 30, 90, 30, 100, 20, 10, 0, 30, 40, 40, 70, 70], top=3) == [100, 90, 70]
end

@testset "Personal top highest to lowest" begin
    @test scores([20, 10, 30], top=3) == [30, 20, 10]
end

@testset "Personal top when there is a tie" begin
    @test scores([40, 20, 40, 30], top = 3) == [40, 40, 30]
end

@testset "Personal top when there are less than 3" begin
    @test scores([30, 70], top=3) == [70, 30]
end

@testset "Personal top when there is only one" begin
    @test scores([40], top=3) == [40]
end
