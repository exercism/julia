using Test

include("robot-revolution.jl")

@testset verbose = true "tests" begin
    @testset "1. Orient the Robot" begin
        @test orientrobot([[-1,1],[1,0],[-1,-1]]) ≈ [-√2/2 1 -√2/2; √2/2 0 -√2/2]
        @test orientrobot([[-1,-3],[0,5],[1,-3]]) ≈ [-1/√10 0 1/√10; -3/√10 1 -3/√10]
    end

    @testset "2. Rotate the Robot" begin
        orientmatrix = [-√2/2 1 -√2/2; √2/2 0 -√2/2]
        @test rotaterobot(orientmatrix, π/2) ≈ [-√2/2 0 √2/2; -√2/2 1 -√2/2]
        @test rotaterobot(orientmatrix, π) ≈ [√2/2 -1 √2/2; -√2/2 0 √2/2]
        @test rotaterobot(orientmatrix, 2π) ≈ [-√2/2 1 -√2/2; √2/2 0 -√2/2]
        @test rotaterobot(orientmatrix, 1.123456) ≈ [-0.9434005735109352 0.4325691034619363 0.33165548073149437; -0.33165548073149437 0.9016007823477843 -0.9434005735109352]
    end

    @testset "3. Check for Correct Orientation" begin
        orientmatrix = [-√2/2 1 -√2/2; √2/2 0 -√2/2]
        @test robotoriented(orientmatrix, [5, 0])
        @test !robotoriented(orientmatrix, [0, 3])
        @test !robotoriented(orientmatrix, [1, 1])
        @test !robotoriented(orientmatrix, [-2, 0])
    end

    @testset "4. Robot Body Coordinates" begin
        orientmatrix = [-√2/2 1 -√2/2; √2/2 0 -√2/2]
        @test bodylocation(orientmatrix, [5, 0]) ≈ [-√2/2+5 6 -√2/2+5; √2/2 0 -√2/2]
        @test bodylocation(orientmatrix, [0, 3]) ≈ [-√2/2 1 -√2/2; √2/2+3 3 -√2/2+3]
        @test bodylocation(orientmatrix, [5, 3]) ≈ [-√2/2+5 6 -√2/2+5; √2/2+3 3 -√2/2+3]
    end
    
end
