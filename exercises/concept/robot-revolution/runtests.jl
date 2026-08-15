using Test

include("robot-revolution.jl")

@testset verbose = true "tests" begin
    @testset "1. Orient the Robot" begin
        @test orientrobot([[-1,1],[1,0],[-1,-1]]) ≈ [-√2/2 1 -√2/2; √2/2 0 -√2/2]
    end

    @testset "2. Rotate the Robot" begin
        orientmatrix = [-√2/2 1 -√2/2; √2/2 0 -√2/2]
        @test rotaterobot(orientmatrix, π/2) ≈ [-√2/2 0 √2/2; -√2/2 1 -√2/2]
    end

    @testset "3. Check for Correct Orientation" begin
        orientmatrix = [-√2/2 1 -√2/2; √2/2 0 -√2/2]
        @test robotoriented(orientmatrix, [5, 0])
        @test !robotoriented(orientmatrix, [0, 3])
        @test !robotoriented(orientmatrix, [-2, 0])
    end

    @testset "4. Robot Body Coordinates" begin
        orientmatrix = [-√2/2 1 -√2/2; √2/2 0 -√2/2]
        @test bodylocation(orientmatrix, [5, 3]) ≈ [-√2/2+5 6 -√2/2+5; √2/2+3 3 -√2/2+3]
    end

    @testset "5. Translate Robot" begin
        @test translaterobot([0, 0], [1, 0], 5) == [5, 0]
        @test translaterobot([3, 2], [√2/2, √2/2], 2) ≈ [√2+3, √2+2]
    end
    
end
