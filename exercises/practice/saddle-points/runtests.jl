using Test

include("saddle-points.jl")

@testset "Can identify single saddle point" begin
    matrix = [9 8 7; 5 3 2; 6 6 7]
    @test saddlepoints(matrix) == [(2, 1)]
end

@testset "Can identify that empty matrix has no saddle points" begin
    matrix = []
    @test saddlepoints(matrix) == []
end

@testset "Can identify lack of saddle points when there are none" begin
    matrix = [1 2 3; 3 1 2; 2 3 1]
    @test saddlepoints(matrix) == []
end

@testset "Can identify multiple saddle points in a column" begin
    matrix = [4 5 4; 3 5 5; 1 5 4]
    @test saddlepoints(matrix) == [(1, 2), (2, 2), (3, 2)]
end

@testset "Can identify multiple saddle points in a row" begin
    matrix = [6 7 8; 5 5 5; 7 5 6]
    @test saddlepoints(matrix) == [(2, 1), (2, 2), (2, 3)]
end

@testset "Can identify saddle point in bottom right corner" begin
    matrix = [8 7 9; 6 7 6; 3 2 5]
    @test saddlepoints(matrix) == [(3, 3)]
end

@testset "Can identify saddle points in a non square matrix" begin
    matrix = [3 1 3; 3 2 4]
    @test saddlepoints(matrix) == [(1, 1), (1, 3)]
end

@testset "Can identify that saddle points in a single column matrix are those with the minimum value" begin
    matrix = reshape([2, 1, 4, 1], :, 1)
    @test saddlepoints(matrix) == [(2, 1), (4, 1)]
end

@testset "Can identify that saddle points in a single row matrix are those with the maximum value" begin
    matrix = [2 5 3 5]
    @test saddlepoints(matrix) == [(1, 2), (1, 4)]
end
