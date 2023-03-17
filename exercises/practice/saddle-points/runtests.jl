using Test

include("saddle-points.jl")

@testset "Can identify single saddle point" begin
    M = [9 8 7; 5 3 2; 6 6 7]
    @test saddlepoints(M) == [(2, 1)]
end

@testset "Can identify that empty matrix has no saddle points" begin
    M = []
    @test saddlepoints(M) == []
end

@testset "Can identify lack of saddle points when there are none" begin
    M = [1 2 3; 3 1 2; 2 3 1]
    @test saddlepoints(M) == []
end

@testset "Can identify multiple saddle points in a column" begin
    M = [4 5 4; 3 5 5; 1 5 4]
    @test saddlepoints(M) == [(1, 2), (2, 2), (3, 2)]
end

@testset "Can identify multiple saddle points in a row" begin
    M = [6 7 8; 5 5 5; 7 5 6]
    @test saddlepoints(M) == [(2, 1), (2, 2), (2, 3)]
end

@testset "Can identify saddle point in bottom right corner" begin
    M = [8 7 9; 6 7 6; 3 2 5]
    @test saddlepoints(M) == [(3, 3)]
end

@testset "Can identify saddle points in a non square matrix" begin
    M = [3 1 3; 3 2 4]
    @test saddlepoints(M) == [(1, 1), (1, 3)]
end

@testset "Can identify that saddle points in a single column matrix are those with the minimum value" begin
    M = reshape([2, 1, 4, 1], :, 1)
    @test saddlepoints(M) == [(2, 1), (4, 1)]
end

@testset "Can identify that saddle points in a single row matrix are those with the maximum value" begin
    M = [2 5 3 5]
    @test saddlepoints(M) == [(1, 2), (1, 4)]
end
