using Test

include("perceptron.jl")
include("testtools.jl")

@testset "Low population" begin
    @testset "Initial set" begin
        points = [[1, 2], [3, 4], [-1, -2], [-3, -4], [2, 1], [1, 1]]
        labels = [1, 1, -1, -1, 1, 1]
        reference = [1, 2, 1]
        hyperplane = perceptron(points, labels)
        @test dotest(points, labels, hyperplane, reference)
    end
    @testset "Initial set w/ opposite labels" begin
        points = [[1, 2], [3, 4], [-1, -2], [-3, -4], [2, 1], [1, 1]]
        labels = [-1, -1, 1, 1, -1, -1]
        reference = [-1, -2, -1]
        hyperplane = perceptron(points, labels)
        @test dotest(points, labels, hyperplane, reference)
    end
    @testset "Hyperplane cannot pass through origin" begin
        points = [[1, 2], [3, 4], [-1, -2], [-3, -4], [2, 1], [-1, -1]]
        labels = [1, 1, -1, -1, 1, 1]
        reference = [-1, 3, 3]
        hyperplane = perceptron(points, labels)
        @test dotest(points, labels, hyperplane, reference)
    end
    @testset "Hyperplane nearly parallel with y-axis" begin
        points = [[0, 50], [0, -50], [-2, 0], [1, 50], [1, -50], [2, 0]]
        labels = [-1, -1, -1, 1, 1, 1]
        reference = [2, 0, -1]
        hyperplane = perceptron(points, labels)
        @test dotest(points, labels, hyperplane, reference)
    end
end

@testset "Increasing Populations" begin
    for n in 10:50
        points, labels, reference = population(n, 25)
        hyperplane = perceptron(points, labels)
        @test dotest(points, labels, hyperplane, reference)
    end
end