using Test, Random
include("perceptron.jl")

@testset "Boundary is a vector of three weights" begin
    decisionboundary = perceptron([[-1,-1], [1, 0], [0, 1]], [-1, 1, 1])
    @test length(decisionboundary) == 3
end

@testset "Weights are Real numbers" begin
    decisionboundary = perceptron([[-1,-1], [1, 0], [0, 1]], [-1, 1, 1])
    @test eltype(decisionboundary) <: Real
end

function runtestset()
    
    @testset "Low populations" begin
        @testset "Initial population" begin
            points = [[-1, 0], [0, -1], [1, 0], [0, 1]]
            labels = [-1, -1, 1, 1]
            reference = [0, 1, 1]
            decisionboundary = perceptron(points, labels)
            @test isvalidboundary(points, labels, decisionboundary, reference)
        end
        @testset "Initial population w/ opposite labels" begin
            points = [[-1, 0], [0, -1], [1, 0], [0, 1]]
            labels = [1, 1, -1, -1]
            reference = [0, -1, -1]
            decisionboundary = perceptron(points, labels)
            @test isvalidboundary(points, labels, decisionboundary, reference)
        end
        @testset "Decision boundary cannot pass through origin" begin
            points = [[1, 0], [0, 1], [2, 1], [1, 2]]
            labels = [-1, -1, 1, 1]
            reference = [-2, 1, 1]
            decisionboundary = perceptron(points, labels)
            @test isvalidboundary(points, labels, decisionboundary, reference)
        end
        @testset "Decision boundary nearly parallel with y-axis" begin
            points = [[0, 50], [0, -50], [1, 50], [1, -50]]
            labels = [-1, -1, 1, 1]
            reference = [-1, 2, 0]
            decisionboundary = perceptron(points, labels)
            @test isvalidboundary(points, labels, decisionboundary, reference)
        end
    end
    
    @testset "Increasing Populations" begin
        for n in 10:50
            points, labels, reference = population(n, 25)
            decisionboundary = perceptron(points, labels)
            @test isvalidboundary(points, labels, decisionboundary, reference)
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

    points, labels, hyperplane
end 

function isvalidboundary(points, labels, hyperplane, reference)
    points = vcat.(1, points)
    test = reduce(hcat, points)' * hyperplane .* labels
    if all(>(0), test)
        println("Reference hyperplane = $reference\nYour hyperplane = $hyperplane\nSeparated! And the normal points towards the positively labeled class\n")
        return true
    elseif all(<(0), test)
        println("Reference hyperplane = $reference\nYour hyperplane = $hyperplane\nSeparated! But the normal points towards the negatively labeled class\n")
        return false
    else
        println("Reference hyperplane = $reference\nYour hyperplane = $hyperplane\nThe classes are not properly separated\n")
        return false
    end
end

Random.seed!(42) # set seed for deterministic test set
runtestset()
