using Test, Random
include("perceptron.jl")

decisionboundary = perceptron([[-1,-1], [1, 0], [0, 1]], [-1, 1, 1])

@testset "Boundary is a vector of three weights" begin
    @test length(decisionboundary) == 3
end

@testset "Weights are Real numbers" begin
    @test eltype(decisionboundary) <: Real
end

function runtestset()
    
    @testset "Low populations" begin

        # Initial population
        points = [[-1, 0], [0, -1], [1, 0], [0, 1]]
        labels = [-1, -1, 1, 1]
        decisionboundary = perceptron(points, labels)
        reference = [0, 1, 1] #A valid decision boundary need not match the reference
        @testset "Initial population - Your decision boundary: $decisionboundary" begin
            @test isvalidboundary(points, labels, decisionboundary)
        end

        #Initial population w/ opposite labels
        points = [[-1, 0], [0, -1], [1, 0], [0, 1]]
        labels = [1, 1, -1, -1]
        decisionboundary = perceptron(points, labels)
        reference = [0, -1, -1] #A valid decision boundary need not match the reference
        @testset "Initial population w/ opposite labels - Your decision boundary: $decisionboundary" begin
            @test isvalidboundary(points, labels, decisionboundary)
        end

        # Decision boundary cannot pass through origin
        points = [[1, 0], [0, 1], [2, 1], [1, 2]]
        labels = [-1, -1, 1, 1]
        decisionboundary = perceptron(points, labels)
        reference = [-2, 1, 1] #A valid decision boundary need not match the reference
        @testset "Decision boundary cannot pass through origin - Your decision boundary: $decisionboundary" begin
            @test isvalidboundary(points, labels, decisionboundary)
        end

        #Decision boundary nearly parallel with y-axis
        points = [[0, 50], [0, -50], [1, 50], [1, -50]]
        labels = [-1, -1, 1, 1]
        decisionboundary = perceptron(points, labels)
        reference = [-1, 2, 0] #A valid decision boundary need not match the reference
        @testset "Decision boundary nearly parallel with y-axis - Your decision boundary: $decisionboundary" begin
            @test isvalidboundary(points, labels, decisionboundary)
        end
        
    end
    
    @testset "Increasing Populations" begin
        for n in 10:50
            points, labels = population(n, 25)
            decisionboundary = perceptron(points, labels)
            @testset "Population: $n points - Your decision boundary: $decisionboundary" begin
                @test isvalidboundary(points, labels, decisionboundary)
            end
        end
    end
    
end


function population(n, bound)
    # Builds a population of n points with labels {1, -1} in area bound x bound around a reference hyperplane
    # Returns linearly separable points, labels and reference hyperplane

    vertical = !iszero(n % 10) #every tenth test has vertical reference hyperplane
    x, y, b = rand(-bound:bound), rand(-bound:bound)*vertical, rand(-bound÷2:bound÷2)
    y_intercept = -b ÷ (iszero(y) ? 1 : y)
    points, labels, hyperplane = [], [], [b, x, y]
    while n > 0
        # points are centered on y-intercept, but not x-intercept so distributions can be lopsided
        point = [rand(-bound:bound), y_intercept + rand(-bound:bound)]
        label = point' * [x, y] + b
        if !iszero(label)
            push!(points, point)
            push!(labels, sign(label))
            n -= 1
        end
    end

    points, labels
end 

function isvalidboundary(points, labels, decisionboundary)
    points = vcat.(1, points)
    all(>(0), reduce(hcat, points)' * decisionboundary .* labels)
end

Random.seed!(42) # set seed for deterministic test set
runtestset()
